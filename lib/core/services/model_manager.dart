import 'dart:async';

import '../config/app_config.dart';
import '../models/model_types.dart';
import 'model_engine.dart';

class ModelManager {
  ModelManager({
    required this.config,
    required this.engines,
    DateTime Function()? clock,
  }) : _clock = clock ?? DateTime.now;

  final AppConfig config;
  final Map<ModelId, ModelEngine> engines;

  final DateTime Function() _clock;

  final Map<ModelId, DateTime> _lastUsed = {};
  final Map<ModelId, int> _leases = {};

  Timer? _expirationTimer;

  /// Starts the background lifecycle monitor.
  void start() {
    _expirationTimer ??= Timer.periodic(
      const Duration(seconds: 30),
      (_) => _expireIdleModels(),
    );
  }

  /// Loads a model if it is not already loaded.
  Future<void> ensureLoaded(ModelId id) async {
    final engine = _engineFor(id);

    if (engine.isLoaded) {
      _touch(id);
      return;
    }

    await engine.load(config.pathFor(id));
    _touch(id);
  }

  /// Acquires a model for active use.
  ///
  /// The returned lease keeps the model from being unloaded while
  /// the caller is using it.
  Future<ModelLease> acquire(ModelId id) async {
    await ensureLoaded(id);

    _leases[id] = (_leases[id] ?? 0) + 1;
    _touch(id);

    return ModelLease._(this, id);
  }

  /// Manually unloads a model.
  ///
  /// A model with active leases or active inference will not be
  /// unloaded unless [force] is true.
  Future<void> unload(
    ModelId id, {
    bool force = false,
  }) async {
    final engine = _engineFor(id);

    if (!engine.isLoaded) {
      return;
    }

    if (!force && (_leases[id] ?? 0) > 0) {
      return;
    }

    if (!force && engine.isBusy) {
      return;
    }

    await engine.unload();

    _lastUsed.remove(id);
  }

  /// Returns true when the vision model is allowed to perform
  /// another scheduled check.
  bool canRunScheduledVisionCheck() {
    final lastCheck = _lastUsed[ModelId.vision];

    if (lastCheck == null) {
      return true;
    }

    return _clock().difference(lastCheck) >=
        config.visionCheckInterval;
  }

  /// Records that a model was used.
  void markUsed(ModelId id) {
    _touch(id);
  }

  void _touch(ModelId id) {
    _lastUsed[id] = _clock();
  }

  void _release(ModelId id) {
    final count = _leases[id] ?? 0;

    if (count <= 1) {
      _leases.remove(id);
    } else {
      _leases[id] = count - 1;
    }

    _touch(id);
  }

  void _expireIdleModels() {
    final now = _clock();

    for (final entry in _lastUsed.entries.toList()) {
      final id = entry.key;
      final lastUsed = entry.value;

      final ttl = config.modelTtls[id];

      if (ttl == null) {
        continue;
      }

      if ((_leases[id] ?? 0) > 0) {
        continue;
      }

      final engine = engines[id];

      if (engine == null || engine.isBusy) {
        continue;
      }

      if (now.difference(lastUsed) < ttl) {
        continue;
      }

      unawaited(unload(id));
    }
  }

  ModelEngine _engineFor(ModelId id) {
    final engine = engines[id];

    if (engine == null) {
      throw StateError(
        'No model engine registered for $id',
      );
    }

    return engine;
  }

  Future<void> dispose() async {
    _expirationTimer?.cancel();
    _expirationTimer = null;

    for (final id in engines.keys) {
      await unload(id, force: true);
    }
  }
}

/// Represents temporary ownership of a model.
///
/// As long as a lease exists, the ModelManager will not automatically
/// unload the corresponding model.
class ModelLease {
  ModelLease._(
    this._manager,
    this.modelId,
  );

  final ModelManager _manager;
  final ModelId modelId;

  bool _released = false;

  void release() {
    if (_released) {
      return;
    }

    _released = true;
    _manager._release(modelId);
  }
}