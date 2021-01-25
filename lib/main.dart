import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:menui_mobile/localizations.dart';
import 'package:menui_mobile/settings.dart';
import "components/homeScreen.dart";

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: () {
      FocusManager.instance.primaryFocus.unfocus();
    }, child: AppBuilder(
      builder: (context) {
        return MaterialApp(
          title: 'Menui - food guide',
          themeMode: ThemeMode.dark,
          theme: ThemeData(
            primarySwatch: Colors.orange,
            primaryColor: Colors.orange,
            accentColor: Colors.grey,
            backgroundColor: Colors.grey,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: HomePage(),
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            const AppLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
          supportedLocales: [
            const Locale('pl', ''),
            const Locale('en', ''),
            const Locale('de', '')
          ],
          localeResolutionCallback:
              (Locale locale, Iterable<Locale> supportedLocales) {
            for (Locale supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale.languageCode ||
                  supportedLocale.countryCode == locale.countryCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
        );
      },
    ));
  }
}
