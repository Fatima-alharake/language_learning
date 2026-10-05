import 'package:flutter/material.dart';

import 'app_startup.dart';

class LanguageLearningApp extends StatelessWidget {
  const LanguageLearningApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Language Learning',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const AppStartup(),
    );
  }
}