import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:prayer_app/model/church.dart';
import 'package:prayer_app/screens/home_screen/views/home_view.dart';
import 'package:prayer_app/screens/loading_screen/loading_view.dart';
import 'package:prayer_app/utils/church_http.dart';
import 'package:prayer_app/utils/user_http.dart';

import 'package:prayer_app/model/user.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return PrayerAppHomeScreen();
  }
}

class PrayerAppHomeScreen extends StatefulWidget {

  PrayerAppHomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<PrayerAppHomeScreen> {

  User _user;
  Church _church = Church();
  FirebaseUser _firebaseUser;
  Widget _view;

  _handleSignIn() async {
    _firebaseUser = await UserHttp().performFirebaseSignIn();
    _user = await UserHttp().fetchUser(_firebaseUser);
    if(_user == null){
      _user = await UserHttp().createUser(_firebaseUser);
    }
    _user.token = await _firebaseUser.getIdToken(refresh: false);
    _church = await ChurchHttp().fetchChurch(_user.church, _user.token);
    setState(() {
      _view = HomeView(
        user: _user,
        church: _church,
        avatarUrl: _firebaseUser != null ? _firebaseUser.photoUrl : null,
      );
    });
  }

  _handleReload() async{
    FirebaseUser firebaseUser = await UserHttp().performFirebaseSignIn();
    String token = await firebaseUser.getIdToken(refresh: false);
    _church = await ChurchHttp().fetchChurch(_user.church, token);
    setState(() {
      _view = HomeView(
        user: _user,
        church: _church,
        avatarUrl: _firebaseUser != null ? _firebaseUser.photoUrl : null,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if(_user == null) {
      _handleSignIn()
          .catchError((e) => print(e));
      _view = LoadingView();
    } else if(_church == null){
      _handleReload();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Prays app'),
      ),
      body: _view,
    );
  }


}
