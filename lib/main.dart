import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:floating_clock/l10n/app_localizations.dart';
import 'package:floating_clock/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final localeManager = LocaleManager();
  await localeManager.loadSavedLanguage();
  runApp(MyApp(localeManager: localeManager));
}

class MyApp extends StatefulWidget {
  final LocaleManager? localeManager;
  const MyApp({super.key, this.localeManager});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final LocaleManager _localeManager;

  @override
  void initState() {
    super.initState();
    _localeManager = widget.localeManager ?? LocaleManager();
    _localeManager.addListener(_onLocaleChanged);
  }

  @override
  void dispose() {
    _localeManager.removeListener(_onLocaleChanged);
    super.dispose();
  }

  void _onLocaleChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return LocaleScope(
      localeManager: _localeManager,
      child: MaterialApp(
        title: 'Floating Clock',
        onGenerateTitle: (context) => AppLocalizations.of(context).appName,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        locale: _localeManager.locale,
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: const HomePage(),
      ),
    );
  }
}
