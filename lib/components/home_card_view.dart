import 'package:flutter/material.dart';
import 'package:prayer_app/model/church.dart';

import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/utils/church_http.dart';

class HomeCardView extends StatelessWidget{

  final User user;
  final Church church;

  HomeCardView({this.user, this.church});

  @override
  Widget build(BuildContext context) {
    if(user.userName == null)
      user.userName = 'No Name';
    if(user.country == null)
      user.country = 'No country';
    if(church.name == null)
      church.name = 'No Church';
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    user.userName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  user.country + ' ' + church.name,
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    return new ListView(
      children: [titleSection],
    );
  }

}