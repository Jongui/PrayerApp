import 'package:flutter/material.dart';
import 'package:prayer_app/components/buttons/float_edit_button.dart';
import 'package:prayer_app/localizations.dart';
import 'package:prayer_app/model/church.dart';
import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/screens/add_user_to_church_screen/add_user_to_church_screen.dart';
import 'package:prayer_app/screens/church_album_screen/church_album_screen.dart';
import 'package:prayer_app/screens/edit_church_screen/edit_church_screen.dart';
import 'package:prayer_app/screens/single_church_view/views/single_church_view.dart';
import 'package:prayer_app/utils/user_http.dart';

class SingleChurchScreen extends StatelessWidget {
  Church church;
  User user;

  SingleChurchScreen({@required this.church, @required this.user});

  @override
  Widget build(BuildContext context) {
    return SingleChurchScreenState(church, user);
  }
}

class SingleChurchScreenState extends StatefulWidget {
  Church church;
  User user;
  SingleChurchScreenState(this.church, this.user);

  _SingleChurchScreenState createState() =>
      _SingleChurchScreenState(church, user);
}

class _SingleChurchScreenState extends State<SingleChurchScreenState> {
  Church church;
  User user;

  bool _reload = false;

  _SingleChurchScreenState(this.church, this.user);

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool _reloadParam = _reload;
    if (_reload) _reload = !_reload;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).viewChurch),
      ),
      body: SingleChurchView(church: church, user: user, reload: _reloadParam),
      floatingActionButton: user.idUser == church.createdBy
          ? FloatEditButton(
              onAddPressed: () async {
                List<User> _users = await UserHttp().getAllUsers(user.token);
                Navigator.of(context)
                    .push(new MaterialPageRoute(
                        builder: (context) => AddUserToChurchScreen(
                              users: _users,
                              church: church,
                              token: user.token,
                            )))
                    .whenComplete(onReload);
              },
              onEditPressed: () {
                Navigator.of(context)
                    .push(new MaterialPageRoute(
                        builder: (context) => EditChurchScreen(
                              church: church,
                              user: user,
                            )))
                    .whenComplete(onReload);
              },
              onAlbumClicked: () {
                Navigator.of(context)
                    .push(new MaterialPageRoute(
                    builder: (context) => ChurchAlbumScreen(
                      church: church,
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
