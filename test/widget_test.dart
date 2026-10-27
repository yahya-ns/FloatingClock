import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:floating_clock/l10n/app_localizations.dart';
import 'package:floating_clock/main.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});

  testWidgets('home page renders clock controls in English', (WidgetTester tester) async {
    final localeManager = LocaleManager();
    await localeManager.setLanguage(AppLanguage.en);

    await tester.pumpWidget(MyApp(localeManager: localeManager));
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Floating Clock'), findsOneWidget);
    expect(find.text('Time Sources'), findsOneWidget);
    expect(find.text('Start Floating'), findsOneWidget);
    expect(find.text('PiP'), findsOneWidget);
  });

  testWidgets('home page renders clock controls in Chinese', (WidgetTester tester) async {
    final localeManager = LocaleManager();
    await localeManager.setLanguage(AppLanguage.zh);

    await tester.pumpWidget(MyApp(localeManager: localeManager));
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('悬浮时间'), findsOneWidget);
    expect(find.text('时间源'), findsOneWidget);
    expect(find.text('开始悬浮'), findsOneWidget);
    expect(find.text('画中画'), findsOneWidget);
  });
}
