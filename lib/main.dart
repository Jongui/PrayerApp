import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'localizations.dart';

import 'model/User.dart';

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

  User _user;
  String _message = "";

  Future<FirebaseUser> _handleSignIn() async {
    FirebaseUser firebaseUser = await _performFirebaseSignIn();
    _user = await fetchUser(firebaseUser);
    if(_user == null){
      _user = await _createUser(firebaseUser);
    }
    setState(() {
      _message = AppLocalizations.of(context).hello + " " + firebaseUser.displayName
       + "Country: " + _user.country;
    });
    return firebaseUser;
  }

  Future<FirebaseUser> _performFirebaseSignIn() async{
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
    FirebaseUser firebaseUser = await _auth.signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    print("signed in " + firebaseUser.displayName);
    return firebaseUser;
  }
  Future<User> fetchUser(FirebaseUser firebaseUser) async {
    final response =
    await http.get('http://192.168.15.7:8080/api/v1/user/email/' + firebaseUser.email
     + '/');

    if (response.statusCode == 200) {
     return User.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }


  @override
  Widget build(BuildContext context) {

    if(_user == null) {
      _handleSignIn()
          .then((FirebaseUser user) => print(user))
          .catchError((e) => print(e));
    }
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(AppLocalizations.of(context).title),
      ),
      body: Text('$_message',
        style: Theme.of(context).textTheme.display1,
      ),
    );
  }

  Future<User> _createUser(FirebaseUser firebaseUser) async {
    User user = User( email: firebaseUser.email,
                      userName: firebaseUser.displayName,
                      city: "Curitiba",
                      country: "Brazil",
                      church: 1);
    final response = await http.post('http://192.168.15.7:8080/api/v1/user',
      headers: {
        "Content-Type": "application/json"
      },
      body: json.encode(user),
      encoding: Encoding.getByName("utf-8")
    );
    if(response.statusCode== 200){

    }
  }
}
