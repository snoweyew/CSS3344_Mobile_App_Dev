import 'package:flutter_test/flutter_test.dart';
import 'package:first_flutter_app/main.dart';

void main() {
  testWidgets('StudentInfoApp smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const StudentInfoApp());

    // Verify that the title text displays.
    expect(find.text('CSS3344 Mobile App Dev - Lab 01'), findsOneWidget);
  });
}
