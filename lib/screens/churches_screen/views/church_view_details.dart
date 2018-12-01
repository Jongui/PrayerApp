import 'package:flutter/material.dart';
import 'package:prayer_app/components/buttons/add_button.dart';
import 'package:prayer_app/screens/add_church_screen/add_church_screen.dart';

class ChurchViewDetails extends StatelessWidget{

  String token;

  Size _screenSize;

  ChurchViewDetails(this.token);

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    return Row(
      children: <Widget>[
      AddButton(screenSize: _screenSize,
      onPressed: () {
        Navigator.of(context).push(
            new MaterialPageRoute(
                builder: (context) => new AddChurchScreen(token)
            ));
        },
      )
      ],
    );
  }

}