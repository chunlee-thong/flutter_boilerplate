import 'package:flutter/material.dart';
import "package:flutter_boilerplate/main_dev.dart" as app;
import 'package:flutter_boilerplate/src/widgets/buttons/primary_button.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('Test Login', () {
    testWidgets('Login and view dummy page', (WidgetTester tester) async {
      final originalOnError = FlutterError.onError!;
      await app.main();
      FlutterError.onError = originalOnError;
      await tester.pumpAndSettle();
      await tester.findAndEnterText(const ValueKey("emailTC"), 'admin@gmail.com');
      await tester.findAndEnterText(const ValueKey("passwordTC"), '123456');
      await tester.tap(find.byType(PrimaryButton));

      //Wait until Login Success
      await tester.waitUntilFindThis(find.text("Profile"));
      await tester.findTextAndTap("Show error dialog");
      // Finder finder = find.text("Dummy");
      // await tester.tap(finder);
      // await tester.pumpAndSettle();
      expect(find.text("Error"), findsOneWidget);
      await tester.findTextAndTap("Dismiss");
      //
    });
  });
}

extension WidgetTesterExtension on WidgetTester {
  Future findAndTap(Key key) async {
    Finder finder = find.byKey(key);
    await tap(finder);
    await pumpAndSettle();
    await Future.delayed(const Duration(seconds: 1));
  }

  Future findTextAndTap(String text) async {
    Finder finder = find.text(text);
    await tap(finder);
    await pumpAndSettle();
    await Future.delayed(const Duration(seconds: 1));
  }

  Future findAndTapSmallDelay(Key key) async {
    Finder finder = find.byKey(key);
    await tap(finder);
    await pumpAndSettle();
    await Future.delayed(const Duration(milliseconds: 200));
  }

  Future delayed() async {
    await Future.delayed(const Duration(milliseconds: 200));
  }

  Future findAndEnterText(Key key, String text) async {
    Finder finder = find.byKey(key);
    await enterText(finder, text);
    await pumpAndSettle();
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> waitUntilFindThis(Finder finder, {int delay = 1000}) async {
    do {
      await pumpAndSettle();
      await Future.delayed(Duration(milliseconds: delay));
    } while (finder.evaluate().isEmpty);
  }
}
