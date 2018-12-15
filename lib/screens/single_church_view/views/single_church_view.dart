import 'package:flutter/material.dart';
import 'package:prayer_app/model/church.dart';
import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/screens/single_church_view/views/single_church_view_header.dart';
import 'package:prayer_app/screens/single_church_view/views/single_church_view_users_list.dart';

class SingleChurchView extends StatelessWidget{

  Church church;
  User user;

  SingleChurchView({@required this.church, @required this.user});

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: <Widget>[
          SingleChurchViewHeader(church: church),
          SingleChurchViewUsersList(church: church,
            user: user,)
        ],
    );
  }

}