import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'localizations.dart';

import 'package:prayer_app/screens/home_screen/home_screen.dart';

//void main() => runApp(new PrayerApp());
void main() => runApp(MaterialApp(
  localizationsDelegates: [
    AppLocalizationsDelegate(),
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ],
  supportedLocales: [
    const Locale('en', ''),
    const Locale('pt', 'BR'),

  ],
  onGenerateTitle: (BuildContext context) =>
  AppLocalizations.of(context).title,
  theme: new ThemeData(
    primarySwatch: Colors.blue,
  ),
  home: new HomeScreen(),
));