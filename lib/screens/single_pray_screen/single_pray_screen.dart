import 'package:flutter/material.dart';
import 'package:prayer_app/components/buttons/float_edit_button.dart';
import 'package:prayer_app/localizations.dart';
import 'package:prayer_app/model/pray.dart';
import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/screens/add_user_to_pray_screen/add_user_to_pray_screen.dart';
import 'package:prayer_app/screens/single_pray_screen/views/single_pray_view.dart';
import 'package:prayer_app/utils/user_http.dart';

class SinglePrayScreen extends StatelessWidget {

  Pray pray;
  User user;

  SinglePrayScreen({@required this.pray, @required this.user});

  @override
  Widget build(BuildContext context) {
    return SinglePrayScreenState(pray, user);
  }

}

class SinglePrayScreenState extends StatefulWidget {

  SinglePrayScreenState(this.pray, this.user, {Key key}) : super(key: key);
  Pray pray;
  User user;

  @override
  _SinglePrayScreenState createState() => _SinglePrayScreenState(pray, user);

}

class _SinglePrayScreenState extends State<SinglePrayScreenState>{

  Pray pray;
  User user;

  _SinglePrayScreenState(this.pray, this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).editYourPray),
      ),
      body: SinglePrayView(pray: pray,
        user: user,
      ),
      floatingActionButton: user.idUser == pray.idUser ? FloatEditButton(
          onAddPressed: ()  async {
            List<User> _users = await UserHttp().getAllUsers(user.token);
            Navigator.of(context).push(
                new MaterialPageRoute(
                    builder: (context) => AddUserToPrayScreen(users: _users,
                      pray: pray,
                      token: user.token,)
                )
            ).whenComplete(onReload);

      }, onEditPressed: () {

      }) : null,
    );

  }

  onReload() {
    setState(() {

    });
  }
}