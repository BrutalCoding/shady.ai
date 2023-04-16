import 'package:flutter_test/flutter_test.dart';
import 'package:shady_ai/main.dart';

void main() {
  testWidgets('Test main instance', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const Main());
  });
}
