import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prayer_app/components/dialogs/confirm_church_membership_dialog.dart';
import 'package:prayer_app/localizations.dart';
import 'package:prayer_app/model/church.dart';
import 'package:prayer_app/screens/edit_user_screen/edit_user_screen.dart';
import 'package:prayer_app/screens/home_screen/views/home_view.dart';
import 'package:prayer_app/screens/loading_screen/loading_view.dart';
import 'package:prayer_app/utils/church_http.dart';
import 'package:prayer_app/utils/firebase_messaging_utils.dart';
import 'package:prayer_app/utils/user_firebase.dart';
import 'package:prayer_app/utils/user_http.dart';

import 'package:prayer_app/model/user.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HomeScreenState();
  }
}

class HomeScreenState extends StatefulWidget {
  HomeScreenState({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenState> {
  User _user;
  Church _church = Church();
  String _token;
  FirebaseUser _firebaseUser;
  Widget _view;

  @override
  void initState() {
    FirebaseMessagingUtils().firebaseCloudMessagingListeners(
        onLaunch: (Map<String, dynamic> message) {},
        onMessage: (Map<String, dynamic> message) {
          _handleOnMessage(message);
        },
        onResume: (Map<String, dynamic> message) {});
  }

  _handleSignIn() async {
    _firebaseUser = await UserFirebase().performFirebaseSignIn();
    _user = await UserHttp().fetchUser(_firebaseUser);
    if (_user == null) {
      _user = await UserHttp().createUser(_firebaseUser);
    }
    if (_user.avatarUrl != _firebaseUser.photoUrl && _user.avatarUrl == null) {
      _user.avatarUrl = _firebaseUser.photoUrl;
      await UserHttp().putUser(_user);
    }
    FirebaseMessagingUtils().subscribeToUserTopic(_user.idUser);
    _church = await ChurchHttp().fetchChurch(_user.church, _user.token);
    _token = await _firebaseUser.getIdToken(refresh: false);
    setState(() {
      _view = HomeView(
        user: _user,
        church: _church,
      );
    });
  }

  _handleReload() async {
    _firebaseUser = await UserFirebase().performFirebaseSignIn();
    _token = await _firebaseUser.getIdToken(refresh: false);
    _church = await ChurchHttp().fetchChurch(_user.church, _token);
    FirebaseMessagingUtils().subscribeToUserTopic(_user.idUser);
    setState(() {
      _view = HomeView(
        user: _user,
        church: _church,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      _handleSignIn().catchError((e) => print(e));
      _view = LoadingView();
    } else if (_church == null) {
      _handleReload();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).title),
        actions: <Widget>[
          IconButton(
            icon: Icon(FontAwesomeIcons.userEdit),
            onPressed: () {
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (context) => new EditUserScreen(_user)));
            },
          ),
        ],
      ),
      body: _view,
    );
  }

  void _handleOnMessage(Map<String, dynamic> message) {
    var _data = message['data'];
    int _action = 0;
    try {
      _action = int.parse(_data['action']);
    } catch (e) {
      print(e);
    }
    switch (_action) {
      case FirebaseMessagingUtils.ADD_USER_TO_CHURCH:
        _handleAddUserToChurch(_data);
        break;
    }
  }

  void _handleAddUserToChurch(dynamic data) async {
    int idChurch = int.parse(data['idChurch']);
    Church _localChurch = await ChurchHttp().fetchChurch(idChurch, _token);
    showDialog(
        context: context,
        builder: (_) => ConfirmChurchMembershipDialog(
              church: _localChurch,
              user: _user,
              token: _token,
            ));
  }
}
