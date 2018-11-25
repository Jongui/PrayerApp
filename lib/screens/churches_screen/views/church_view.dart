import 'package:flutter/material.dart';
import 'package:prayer_app/model/church.dart';
import 'package:prayer_app/screens/churches_screen/views/church_view_details.dart';

import 'package:prayer_app/screens/churches_screen/views/church_view_header.dart';

class ChurchView extends StatelessWidget{

  Church church;
  String token;

  ChurchView(this.church, this.token);

  @override
  Widget build(BuildContext context) {
    return new ListView(
        children: <Widget>[
          ChurchViewHeader(church, token),
          ChurchViewDetails(token),
        ]
    );
  }
}