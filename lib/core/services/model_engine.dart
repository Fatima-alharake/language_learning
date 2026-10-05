import '../models/chat_message.dart';
import '../models/model_types.dart';

/// Base interface shared by every local inference engine.
///
/// The application talks to this interface rather than directly to
/// llama.cpp, Moonshine, LiteRT, or any other runtime.
abstract interface class ModelEngine {
  ModelId get id;
  bool get isLoaded;
  bool get isBusy;

  Future<void> load(String modelPath);

  Future<void> unload();
}

abstract interface class LlmEngine implements ModelEngine {
  Stream<String> generate({
    required List<ChatMessage> history,
    required String systemPrompt,
  });
}

abstract interface class AsrEngine implements ModelEngine {
  Future<String> transcribe(List<int> audioBytes);
}

abstract interface class TtsEngine implements ModelEngine {
  Future<void> speak(String text);
}

abstract interface class VisionEngine implements ModelEngine {
  Future<List<String>> detect(List<int> imageBytes);
}