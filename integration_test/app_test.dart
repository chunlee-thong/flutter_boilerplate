import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../lib/main_dev.dart' as app;
import '../lib/src/widgets/buttons/primary_button.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('Test login and view profile', () {
    testWidgets('tap on the floating action button, verify counter', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(const ValueKey("emailTC")), 'admin@gmail.com');
      await tester.enterText(find.byKey(const ValueKey("passwordTC")), '123456');
      await tester.tap(find.byType(PrimaryButton));
    });
  });
}
