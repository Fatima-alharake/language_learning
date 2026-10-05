import 'package:shared_preferences/shared_preferences.dart';

class LanguagePreferences {
  static const _targetLanguageKey = 'target_language';

  Future<String?> getTargetLanguageCode() async {
    final preferences = await SharedPreferences.getInstance();

    return preferences.getString(_targetLanguageKey);
  }

  Future<void> setTargetLanguageCode(String code) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setString(
      _targetLanguageKey,
      code,
    );
  }

  Future<void> clearTargetLanguage() async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.remove(_targetLanguageKey);
  }
}