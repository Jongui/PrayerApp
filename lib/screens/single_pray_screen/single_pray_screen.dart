import 'package:flutter/material.dart';
import 'package:prayer_app/components/buttons/float_edit_button.dart';
import 'package:prayer_app/localizations.dart';
import 'package:prayer_app/model/pray.dart';
import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/model/user_pray.dart';
import 'package:prayer_app/screens/add_user_to_pray_screen/add_user_to_pray_screen.dart';
import 'package:prayer_app/screens/edit_pray_screen/edit_pray_screen.dart';
import 'package:prayer_app/screens/pray_album_screen/pray_album_screen.dart';
import 'package:prayer_app/screens/single_pray_screen/views/single_pray_view.dart';
import 'package:prayer_app/utils/user_http.dart';

class SinglePrayScreen extends StatelessWidget {
  Pray pray;
  User user;
  UserPray userPray;

  SinglePrayScreen(
      {@required this.pray, @required this.user, @required this.userPray});

  @override
  Widget build(BuildContext context) {
    return SinglePrayScreenState(pray, user, userPray);
  }
}

class SinglePrayScreenState extends StatefulWidget {
  SinglePrayScreenState(this.pray, this.user, this.userPray, {Key key})
      : super(key: key);
  Pray pray;
  User user;
  UserPray userPray;

  @override
  _SinglePrayScreenState createState() =>
      _SinglePrayScreenState(pray, user, userPray);
}

class _SinglePrayScreenState extends State<SinglePrayScreenState> {
  Pray pray;
  User user;
  UserPray userPray;
  bool _reload = false;

  _SinglePrayScreenState(this.pray, this.user, this.userPray);

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool _reloadParam = _reload;
    if(_reload)
      _reload = !_reload;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).editYourPray),
      ),
      body: SinglePrayView(
        pray: pray,
        user: user,
        userPray: userPray,
        token: user.token,
        reload: _reloadParam
      ),
      floatingActionButton: user.idUser == pray.idUser
          ? FloatEditButton(
              onAddPressed: () async {
                List<User> _users = await UserHttp().getAllUsers(user.token);
                Navigator.of(context)
                    .push(new MaterialPageRoute(
                        builder: (context) => AddUserToPrayScreen(
                              users: _users,
                              pray: pray,
                              token: user.token,
                            )))
                    .whenComplete(onReload);
              },
              onEditPressed: () {
                Navigator.of(context)
                    .push(new MaterialPageRoute(
                        builder: (context) => EditPrayScreen(
                              pray: pray,
                              token: user.token,
                            )))
                    .whenComplete(onReload);
              },
              onAlbumClicked: () {
                Navigator.of(context)
                    .push(new MaterialPageRoute(
                    builder: (context) => PrayAlbumScreen(
                      pray: pray,
                      token: user.token,
                    )))
                    .whenComplete(onReload);
              },
            )
          : null,
    );
  }

  onReload() {
    setState(() {
      _reload = true;
    });
  }
}
