import 'package:flutter/material.dart';
import 'package:prayer_app/components/views/country_flag_view.dart';
import 'package:prayer_app/model/user.dart';

class UserView extends StatelessWidget{

  User user;
  UserView({@required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
          width: 300.0,
          margin: EdgeInsets.only(left: 10.0),
          child: ListTile(
              title: Text(user.userName,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),),
              subtitle: CountyFlagView(country: user.country,
                width: 32.0,
                height: 32.0,
                color: Colors.black,))
      );
  }

}