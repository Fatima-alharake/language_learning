import 'package:flutter_test/flutter_test.dart';

import 'package:language_learning_app/app/app.dart';

void main() {
  testWidgets('App starts successfully', (tester) async {
    await tester.pumpWidget(const LanguageLearningApp());

    expect(find.text('Language Learning App'), findsOneWidget);
  });
}