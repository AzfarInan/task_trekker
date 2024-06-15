import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_trekker/core/dependency/injection.dart';
import 'package:task_trekker/main.dart';

void main() {
  setUpAll(() {
    configureDependencies();
  });

  testWidgets('Splash Screen shows a CircularProgressIndicator', (WidgetTester tester) async {
    // Save the original ErrorWidget.builder
    final originalErrorWidgetBuilder = ErrorWidget.builder;

    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that a CircularProgressIndicator is displayed.
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Reset the ErrorWidget.builder to its original value
    ErrorWidget.builder = originalErrorWidgetBuilder;
  });
}
