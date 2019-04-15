import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prayer_app/components/dialogs/confirm_church_membership_dialog.dart';
import 'package:prayer_app/components/dialogs/confirm_pray_membership_dialog.dart';
import 'package:prayer_app/localizations.dart';
import 'package:prayer_app/model/church.dart';
import 'package:prayer_app/model/pray.dart';
import 'package:prayer_app/screens/edit_user_screen/edit_user_screen.dart';
import 'package:prayer_app/screens/home_screen/views/home_view.dart';
import 'package:prayer_app/screens/loading_screen/loading_view.dart';
import 'package:prayer_app/utils/church_http.dart';
import 'package:prayer_app/utils/firebase_admob_utils.dart';
import 'package:prayer_app/utils/firebase_messaging_utils.dart';
import 'package:prayer_app/utils/pray_http.dart';
import 'package:prayer_app/utils/user_firebase.dart';
import 'package:prayer_app/utils/user_http.dart';

import 'package:prayer_app/model/user.dart';

//ca-app-pub-9634352911405361/9366381029
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
  List<Widget> _actions;

  @override
  void dispose() {
    FirebaseAdmobUtils().disposeScreenBanner();
    _actions = [];
    super.dispose();
  }

  @override
  void initState() {
    FirebaseAdmobUtils().initScreenBanner();
    FirebaseAdmobUtils().loadScreenBanner();
  }

  _handleSignIn() async {
    _firebaseUser = await UserFirebase().performFirebaseSignIn();
    _user = await UserHttp().fetchUser(_firebaseUser);
    if (_user == null) {
      _user = await UserHttp().createUser(_firebaseUser);
    }
    _handlePendingInvitation();
    if (_user.avatarUrl != _firebaseUser.photoUrl && _user.avatarUrl == null) {
      _user.avatarUrl = _firebaseUser.photoUrl;
      await UserHttp().putUser(_user);
    }
    FirebaseMessagingUtils().subscribeToUserTopic(_user.idUser);
    _church = await ChurchHttp().fetchChurch(_user.church, _user.token);
    _token = await _firebaseUser.getIdToken(refresh: false);
    setState(() {
      _populateActions();
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
      _populateActions();
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
      _actions = [];
      _view = LoadingView();
    } else if (_church == null) {
      _handleReload();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).title),
        actions: _actions,
      ),
      body: _view,
    );
  }

  void _handlePendingInvitation() async {
    DatabaseReference _churchInvitations =
        await UserFirebase().readPendingChurchInvitations(_user.idUser);
    _churchInvitations.onChildAdded.listen((event) async {
      DataSnapshot invitationSnapshot = event.snapshot;
      if (invitationSnapshot.value == null) {
        return;
      }
      int _idChurch = invitationSnapshot.value;
      Church _localChurch = await ChurchHttp().fetchChurch(_idChurch, _token);
      showDialog(
          context: context,
          builder: (_) => ConfirmChurchMembershipDialog(
                church: _localChurch,
                user: _user,
                token: _token,
              ));
    });
    DatabaseReference _prayInvitations =
        await UserFirebase().readPendingPrayInvitations(_user.idUser);
    _prayInvitations.onChildAdded.listen((event) async {
      int _idPray = int.parse(event.snapshot.key);
      Pray _localPray = await PrayHttp().getPrayById(_idPray, _token);
      await showDialog(
          context: context,
          builder: (_) => ConfirmPrayMembershipDialog(
                pray: _localPray,
                user: _user,
                token: _token,
              ));
    });
  }

  onReload() async {
    FirebaseAdmobUtils().initScreenBanner();
    await FirebaseAdmobUtils().loadScreenBanner();
  }

  void _disposeScreenBanner() {
    FirebaseAdmobUtils().disposeScreenBanner();
  }

  void _populateActions() {
    _actions = <Widget>[
      IconButton(
        icon: Icon(FontAwesomeIcons.userEdit),
        onPressed: () {
          _disposeScreenBanner();
          Navigator.of(context)
              .push(new MaterialPageRoute(
              builder: (context) => new EditUserScreen(_user)))
              .whenComplete(onReload);
        },
      ),
    ];
  }
}
