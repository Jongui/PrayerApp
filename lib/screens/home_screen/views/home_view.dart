import 'package:flutter/material.dart';
import 'package:prayer_app/model/church.dart';

import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/screens/home_screen/views/home_view_actions.dart';
import 'package:prayer_app/screens/home_screen/views/home_view_header.dart';

class HomeView extends StatelessWidget{

  User user;
  Church church;
  String avatarUrl;

  HomeView({this.user, this.church, this.avatarUrl});

  @override
  Widget build(BuildContext context) {
    if(user == null)
      user = User();

    if(church == null)
      church = Church();

    return new ListView(
      children: <Widget>[
        HomeViewHeader(avatarUrl, user),
        HomeViewActions(user, church),
      ]
    );
  }
}