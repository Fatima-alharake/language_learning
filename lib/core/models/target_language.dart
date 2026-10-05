import 'package:flutter/foundation.dart';

@immutable
class TargetLanguage {
  const TargetLanguage({
    required this.code,
    required this.name,
  });

  final String code;
  final String name;
}

abstract final class TargetLanguages {
  static const french = TargetLanguage(
    code: 'fr',
    name: 'French',
  );

  static const spanish = TargetLanguage(
    code: 'es',
    name: 'Spanish',
  );

  static const german = TargetLanguage(
    code: 'de',
    name: 'German',
  );

  static const italian = TargetLanguage(
    code: 'it',
    name: 'Italian',
  );

  static const english = TargetLanguage(
    code: 'en',
    name: 'English',
  );

  static const portuguese = TargetLanguage(
    code: 'pt',
    name: 'Portuguese',
  );

  static const japanese = TargetLanguage(
    code: 'ja',
    name: 'Japanese',
  );

  static const korean = TargetLanguage(
    code: 'ko',
    name: 'Korean',
  );

  static const List<TargetLanguage> all = [
    french,
    spanish,
    german,
    italian,
    english,
    portuguese,
    japanese,
    korean,
  ];

  static TargetLanguage? fromCode(String code) {
    for (final language in all) {
      if (language.code == code) {
        return language;
      }
    }

    return null;
  }
}