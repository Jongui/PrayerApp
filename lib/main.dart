import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'localizations.dart';

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
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int _counter = 0;
  Future<FirebaseUser> _handleSignIn() async {
    // Attempt to get the currently authenticated user
    GoogleSignInAccount currentUser = _googleSignIn.currentUser;
    if (currentUser == null) {
      // Attempt to sign in without user interaction
      currentUser = await _googleSignIn.signInSilently();
    }
    if (currentUser == null) {
      // Force the user to interactively sign in
      currentUser = await _googleSignIn.signIn();
    }
    GoogleSignInAuthentication googleAuth = await currentUser.authentication;
    FirebaseUser user = await _auth.signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    print("signed in " + user.displayName);
    return user;
  }

  @override
  Widget build(BuildContext context) {

    _handleSignIn()
        .then((FirebaseUser user) => print(user))
        .catchError((e) => print(e));
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(AppLocalizations.of(context).title),
      ),
      body: Text(
        AppLocalizations.of(context).hello,
        style: Theme.of(context).textTheme.display1,

      ),
    );
  }
}
