import 'package:flutter/material.dart';
import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/screens/churches_screen/views/churches_list_views.dart';

class ChurchesView extends StatelessWidget{

  User user;

  ChurchesView({@required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 50.0),
      child: ChurchesListView(user: user,),
    );
  }
}