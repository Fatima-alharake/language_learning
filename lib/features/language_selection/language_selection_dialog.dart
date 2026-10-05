import 'package:flutter/material.dart';

import '../../core/models/target_language.dart';

class LanguageSelectionDialog extends StatelessWidget {
  const LanguageSelectionDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('What language do you want to learn?'),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: TargetLanguages.all.length,
          itemBuilder: (context, index) {
            final language = TargetLanguages.all[index];

            return ListTile(
              title: Text(language.name),
              onTap: () {
                Navigator.of(context).pop(language);
              },
            );
          },
        ),
      ),
    );
  }
}