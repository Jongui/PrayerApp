import 'package:flutter/material.dart';
import 'package:prayer_app/model/pray.dart';
import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/screens/edit_pray_screen/views/edit_pray_view_header.dart';
import 'package:prayer_app/screens/edit_pray_screen/views/edit_pray_view_users.dart';

class EditPrayView extends StatelessWidget{
  Pray pray;
  User user;

  EditPrayView({@required this.pray, @required this.user});

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: <Widget>[
          EditPrayViewHeader(pray: pray,
            user: user,),
          EditPrayViewUsers(pray: pray,
            token: user.token,)
        ]
    );
  }

}