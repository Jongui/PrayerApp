import 'package:flutter/material.dart';
import 'package:prayer_app/model/pray.dart';
import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/screens/single_pray_screen/views/single_pray_view_header.dart';
import 'package:prayer_app/screens/single_pray_screen/views/single_pray_view_users.dart';

class SinglePrayView extends StatelessWidget{
  Pray pray;
  User user;

  SinglePrayView({@required this.pray, @required this.user});

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: <Widget>[
          SinglePrayViewHeader(pray: pray,
            user: user,),
          SinglePrayViewUsers(pray: pray,
            token: user.token,)
        ]
    );
  }

}