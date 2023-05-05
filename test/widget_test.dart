import 'package:flutter_test/flutter_test.dart';
import 'package:solid_software_test_task/src/solid_software_task_app.dart';

void main() {
  testWidgets('Widget test', (widgetTester) async {
    final textWidget = find.text('Hello world');

    await widgetTester.pumpWidget(const SolidSoftwareTaskApp());
    await widgetTester.pumpAndSettle();

    expect(textWidget, findsOneWidget);

    await widgetTester.tap(textWidget);
    await widgetTester.pumpAndSettle();

    expect(textWidget, findsOneWidget);
  });
}
