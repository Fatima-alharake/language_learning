import 'package:flutter/material.dart';

import '../../core/models/target_language.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({
    required this.targetLanguage,
    super.key,
  });

  final TargetLanguage targetLanguage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Learning ${targetLanguage.name}'),
      ),
      body: Center(
        child: Text(
          'Ready to practice ${targetLanguage.name}!',
        ),
      ),
    );
  }
}