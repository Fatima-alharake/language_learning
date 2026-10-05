import 'package:flutter/foundation.dart';

@immutable
class TargetLanguage {
  const TargetLanguage({
    required this.code,
    required this.name,
  });

  final String code;
  final String name;

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
}