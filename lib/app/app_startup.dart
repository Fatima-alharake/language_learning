import 'package:flutter/material.dart';

import '../core/models/target_language.dart';
import '../core/storage/language_preferences.dart';
import '../core/storage/language_repository.dart';
import '../features/chat/chat_page.dart';
import '../features/language_selection/language_selection_controller.dart';
import '../features/language_selection/language_selection_dialog.dart';

class AppStartup extends StatefulWidget {
  const AppStartup({
    super.key,
  });

  @override
  State<AppStartup> createState() => _AppStartupState();
}

class _AppStartupState extends State<AppStartup> {
  late final LanguageSelectionController _languageController;

  @override
  void initState() {
    super.initState();

    _languageController = LanguageSelectionController(
      repository: LanguageRepository(
        preferences: LanguagePreferences(),
      ),
    );

    _initialize();
  }

  Future<void> _initialize() async {
    await _languageController.load();

    if (!mounted) {
      return;
    }

    if (_languageController.hasSelectedLanguage) {
      _openChat(_languageController.selectedLanguage!);
      return;
    }

    final language = await showDialog<TargetLanguage>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const LanguageSelectionDialog(),
    );

    if (!mounted || language == null) {
      return;
    }

    await _languageController.selectLanguage(language);

    if (!mounted) {
      return;
    }

    _openChat(language);
  }

  void _openChat(TargetLanguage language) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => ChatPage(
          targetLanguage: language,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _languageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}