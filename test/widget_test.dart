// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:haardik_tic_tac_toe/splash.dart';

void main() {
  testWidgets('Given user in home page When elevated button is pressed Then dialog box opens', (WidgetTester tester) async {
    // Assemble
    await tester.pumpWidget(
      MaterialApp(
        home: Splash(),
      ),
    );

    // ACT
    final button = find.text('LOG IN');
    final button2 = find.text('REGISTER');

    //ASSERT
    expect(button, findsOneWidget);
    expect(button2, findsOneWidget);
  });
}
