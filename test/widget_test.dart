import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';
import 'package:task_trekker/core/dependency/injection.dart';
import 'package:task_trekker/features/kanban_board/presentation/pages/kanban_dashboard_screen.dart';
import 'package:task_trekker/main.dart';

void main() {
  setUpAll(() {
    configureDependencies();
  });

  testWidgets('Splash Screen shows an Animation and navigates to KanbanDashboardScreen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the splash screen is displayed
    expect(find.byType(Lottie), findsOneWidget);

    // Simulate the delay
    await tester.pumpAndSettle(const Duration(seconds: 10));

    // Verify that the KanbanDashboardScreen is displayed
    expect(find.byType(KanbanDashboardScreen), findsOneWidget);
  });
}
