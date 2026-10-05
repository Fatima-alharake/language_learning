import 'package:flutter/foundation.dart';

import '../models/model_types.dart';

@immutable
class AppConfig {
  const AppConfig({
    required this.modelPaths,
    required this.modelTtls,
    required this.visionCheckInterval,
    required this.systemPromptBase,
  });

  final Map<ModelId, String> modelPaths;
  final Map<ModelId, Duration> modelTtls;
  final Duration visionCheckInterval;

  /// Language-independent instructions for the LLM.
  final String systemPromptBase;

  factory AppConfig.defaults() {
    return const AppConfig(
      modelPaths: {
        ModelId.llm:
            'models/llama-3.2-3b-instruct-q4_k_m.gguf',
        ModelId.asr:
            'models/moonshine-base.tflite',
        ModelId.tts:
            'models/tts.tflite',
        ModelId.vision:
            'models/yolo.tflite',
      },
      modelTtls: {
        ModelId.asr: Duration(minutes: 5),
        ModelId.tts: Duration(minutes: 5),
        ModelId.vision: Duration(minutes: 5),
      },
      visionCheckInterval: Duration(minutes: 5),
      systemPromptBase:
          'You are a patient language-learning companion. '
          'Correct mistakes gently, encourage the learner, '
          'and adapt difficulty to the conversation. '
          'You can speak about anything; the goal is to have '
          'natural conversations that help the user learn to '
          'express themselves and speak. '
          'Treat all people with respect and do not produce '
          'racist or discriminatory content.',
    );
  }

  String buildSystemPrompt(String targetLanguage) {
    final language = targetLanguage.trim();

    if (language.isEmpty) {
      throw ArgumentError(
        'Target language cannot be empty.',
      );
    }

    return '''
$systemPromptBase

The user is learning $language.

The user will speak with you primarily in $language.
Reply in $language unless the user explicitly asks you
to use another language.

Your goal is to help the user practice expressing themselves
naturally in $language through conversation.
''';
  }

  String pathFor(ModelId id) {
    final path = modelPaths[id];

    if (path == null || path.isEmpty) {
      throw StateError(
        'No model path configured for $id',
      );
    }

    return path;
  }
}