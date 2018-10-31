import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:prayer_app/model/church.dart';
import 'package:prayer_app/utils/church_http.dart';
import 'package:prayer_app/utils/user_http.dart';
import 'localizations.dart';

import 'package:prayer_app/model/user.dart';
import 'components/home_card_view.dart';

void main() => runApp(new PrayerApp());

class PrayerApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      localizationsDelegates: [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''), // English
        const Locale('pt', ''), // Portuguese
        // ... other locales the app supports
      ],
      onGenerateTitle: (BuildContext context) =>
      AppLocalizations.of(context).title,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new PrayerAppHomePage(title: 'Flutter Demo Home Page'),
    );
  }

}

class PrayerAppHomePage extends StatefulWidget {

  PrayerAppHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<PrayerAppHomePage> {

  User _user;
  Church _church = Church();

  Future<FirebaseUser> _handleSignIn() async {
    FirebaseUser firebaseUser = await UserHttp().performFirebaseSignIn();
    _user = await UserHttp().fetchUser(firebaseUser);
    if(_user == null){
      String token = await firebaseUser.getIdToken(refresh: false);
      _user = await UserHttp().createUser(firebaseUser);
      _church = await ChurchHttp().fetchChurch(_user.church, token);
    }
    setState(() {
    });
    return firebaseUser;
  }

  @override
  Widget build(BuildContext context) {

    if(_user == null) {
      _handleSignIn()
          .then((FirebaseUser user) => print(user))
          .catchError((e) => print(e));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).title),
      ),
      body: HomeCardView(
        user: _user,
        church: _church,
      ),
    );
  }


}
