import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prayer_app/components/buttons/grid_button.dart';
import 'package:prayer_app/model/church.dart';
import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/screens/churches_screen/churches_screen.dart';
import 'package:prayer_app/screens/prays_screen/prays_screen.dart';

class HomeViewActions extends StatelessWidget{

  Church church;
  User user;

  Size _screenSize;

  HomeViewActions(this.user, this.church);

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    return new Container(
      width: _screenSize.width,
      height: _screenSize.height / 3,
      color: Colors.white30,
      child: _buildGridButtons(context),
    );
  }

  Widget _buildGridButtons(BuildContext context){
    double buttonHeight = _screenSize.height / 3 / 4;
    double buttonWidth = _screenSize.width / 2 / 4;
    return new GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        padding: const EdgeInsets.only(left: 36.0, right: 36.0, bottom: 48.0, top: 36.0),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 36.0,
        children: <Widget>[
          GridButton(
            buttonHeight: buttonHeight,
            buttonWidth: buttonWidth,
            buttonPadding: EdgeInsets.only(right: 28.0),
            padding: EdgeInsets.all(0.0),
            border: Border.all(color: Colors.blueGrey),
            icon: Icon(FontAwesomeIcons.church,
                color: Colors.blueGrey,
                size: 96.0
            ),
            onPressed: () {
              Navigator.of(context).push(
                  new MaterialPageRoute(
                      builder: (context) => new ChurchesScreen(church: church,
                          user: user)
                  ));
            },
          ),
          GridButton(
            buttonHeight: buttonHeight,
            buttonWidth: buttonWidth,
            buttonPadding: EdgeInsets.all(0.0),
            padding: EdgeInsets.all(0.0),
            border: Border.all(color: Colors.blueGrey),
            icon: Icon(FontAwesomeIcons.pray,
                color: Colors.blueGrey,
                size: 96.0
            ),
            onPressed: () {
              Navigator.of(context).push(
                  new MaterialPageRoute(
                      builder: (context) => PraysScreen(user: user)
                  ));
              },
          ),
        ]
    );
  }

}