import 'package:flutter/material.dart';

import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/screens/prays_screen/views/prays_list_view.dart';

class PrayView extends StatelessWidget{

  User user;
  String token;

  PrayView({@required this.user, @required this.token});

  @override
  Widget build(BuildContext context) {
    if(user == null)
      user = User();

    return SingleChildScrollView(
        child: SingleChildScrollView(
          child: Container(
            decoration: new BoxDecoration(
              color: Colors.white30
            ),
            child: new Column(
              children: <Widget>[
                PrayListView(user: user, token: token,),
              ],
            ),
          )
        )
    );
  }
}