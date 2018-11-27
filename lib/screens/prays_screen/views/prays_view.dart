import 'package:flutter/material.dart';

import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/screens/prays_screen/views/prays_view_header.dart';

class PrayView extends StatelessWidget{

  User user;

  PrayView(this.user);

  @override
  Widget build(BuildContext context) {
    if(user == null)
      user = User();

    return SingleChildScrollView(
        child: Container(
          decoration: new BoxDecoration(
              color: Colors.white30
          ),
          child: new Column(
            children: <Widget>[
              PrayViewHeader(user),
              Divider(),
            ],
          ),
        )
    );
  }
}