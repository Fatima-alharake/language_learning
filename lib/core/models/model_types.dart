enum ModelId {
  llm,
  asr,
  tts,
  vision,
}

enum ModelState {
  unloaded,
  loading,
  ready,
  busy,
  unloading,
}

enum MessageRole {
  user,
  assistant,
  system,
}