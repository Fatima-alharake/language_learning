import 'package:flutter/foundation.dart';

import '../../core/models/target_language.dart';
import '../../core/storage/language_repository.dart';

class LanguageSelectionController extends ChangeNotifier {
  LanguageSelectionController({
    required LanguageRepository repository,
  }) : _repository = repository;

  final LanguageRepository _repository;

  TargetLanguage? _selectedLanguage;
  bool _isLoading = true;

  TargetLanguage? get selectedLanguage => _selectedLanguage;
  bool get isLoading => _isLoading;
  bool get hasSelectedLanguage => _selectedLanguage != null;

  Future<void> load() async {
    _isLoading = true;
    notifyListeners();

    _selectedLanguage = await _repository.getSelectedLanguage();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> selectLanguage(
    TargetLanguage language,
  ) async {
    await _repository.saveSelectedLanguage(language);

    _selectedLanguage = language;
    notifyListeners();
  }

  Future<void> clearLanguage() async {
    await _repository.clearSelectedLanguage();

    _selectedLanguage = null;
    notifyListeners();
  }
}