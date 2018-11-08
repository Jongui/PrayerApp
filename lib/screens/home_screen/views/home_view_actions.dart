import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeViewActions extends StatelessWidget{

  Size _screenSize;

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    return new Container(
      width: _screenSize.width,
      height: _screenSize.height / 3,
      color: Colors.white30,
      child: new GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
          padding: const EdgeInsets.all(4.0),
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          children: <Widget>[
            Container(
              width: 50.0,
              height: 50.0,
              padding: const EdgeInsets.all(0.0),//I used some padding without fixed width and height
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: IconButton(
                // Use the FontAwesomeIcons class for the IconData
                icon: Icon(FontAwesomeIcons.church,
                color: Colors.lightBlueAccent,),
                alignment: Alignment.center,
                padding: EdgeInsets.all(0.0),
                onPressed: () { print("Pressed"); },

              ),
            ),
          ]
      ),
    );
  }

}