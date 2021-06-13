import 'package:flutter/material.dart';
import 'package:flutter_localization/l10n/l10n.dart';
import 'package:flutter_localization/providers/locale_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
      ],
      child: Consumer<LocaleProvider>(builder: (context, provider, snapshot) {
        return MaterialApp(
          title: 'Flutter Localization',
          theme: ThemeData(primarySwatch: Colors.blue),
          locale: provider.locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: L10n.all,
          home: HomePage(),
        );
      }),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _title(String val) {
      switch (val) {
        case 'en':
          return Text(
            'English',
            style: TextStyle(fontSize: 16.0),
          );
        case 'id':
          return Text(
            'Bahasa Indonesia',
            style: TextStyle(fontSize: 16.0),
          );

        default:
          return Text(
            'English',
            style: TextStyle(fontSize: 16.0),
          );
      }
    }

    return Consumer<LocaleProvider>(builder: (context, provider, snapshot) {
      var lang = provider.locale ?? Localizations.localeOf(context);
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.english_language,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 25.0),
              DropdownButton(
                  value: lang,
                  onChanged: (Locale? val) {
                    provider.setLocale(val!);
                  },
                  items: L10n.all
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: _title(e.languageCode),
                          ))
                      .toList())
            ],
          ),
        ),
      );
    });
  }
}
