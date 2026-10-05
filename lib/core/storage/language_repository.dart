import '../models/target_language.dart';
import 'language_preferences.dart';

class LanguageRepository {
  LanguageRepository({
    required LanguagePreferences preferences,
  }) : _preferences = preferences;

  final LanguagePreferences _preferences;

  Future<TargetLanguage?> getSelectedLanguage() async {
    final code = await _preferences.getTargetLanguageCode();

    if (code == null) {
      return null;
    }

    return TargetLanguages.fromCode(code);
  }

  Future<void> saveSelectedLanguage(
    TargetLanguage language,
  ) async {
    await _preferences.setTargetLanguageCode(
      language.code,
    );
  }

  Future<void> clearSelectedLanguage() async {
    await _preferences.clearTargetLanguage();
  }
}