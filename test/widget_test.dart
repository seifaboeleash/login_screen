import 'package:flutter_test/flutter_test.dart';
import 'package:login_screen/main.dart';

void main() {
  testWidgets('Login page renders welcome header', (WidgetTester tester) async {
    await tester.pumpWidget(const LoginApp());

    expect(find.text('Welcome Back'), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);
  });
}
