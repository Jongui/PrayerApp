import 'package:flutter/material.dart';
import 'package:prayer_app/model/pray.dart';
import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/model/user_pray.dart';
import 'package:prayer_app/screens/single_pray_screen/views/single_pray_view_header.dart';
import 'package:prayer_app/screens/single_pray_screen/views/single_pray_view_users.dart';

class SinglePrayView extends StatelessWidget {
  Pray pray;
  User user;
  UserPray userPray;
  String token;

  SinglePrayView(
      {@required this.pray, @required this.user, @required this.userPray, @required this.token});

  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      SinglePrayViewHeader(
        pray: pray,
        user: user,
        userPray: userPray,
        token: token,
      ),
      SinglePrayViewUsers(
        pray: pray,
        token: user.token,
      )
    ]);
  }
}
