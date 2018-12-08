import 'package:flutter/material.dart';
import 'package:prayer_app/model/church.dart';
import 'package:prayer_app/screens/churches_screen/views/churches_list_views.dart';

class ChurchView extends StatelessWidget{

  Church church;
  String token;

  ChurchView(this.church, this.token);

  @override
  Widget build(BuildContext context) {
    return ChurchesListView(token: token,);
  }
}