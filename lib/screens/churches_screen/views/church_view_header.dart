import 'package:flutter/material.dart';
import 'package:prayer_app/components/views/country_flag_view.dart';
import 'package:prayer_app/components/buttons/edit_button.dart';
import 'package:prayer_app/model/church.dart';
import 'package:prayer_app/screens/edit_church_screen/edit_church_screen.dart';

class ChurchViewHeader extends StatelessWidget {

  Church church;
  String token;

  Size _screenSize;

  ChurchViewHeader(this.church, this.token);

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: Container(
          decoration: new BoxDecoration(
            color: Colors.white30
          ),
          child: new Column(
            children: <Widget>[
              _buildInfos(),
              _buildBarButton(context),
              Divider(),
            ],
          ),
        )
    );
  }

  Widget _buildInfos(){
    return Container(
        padding: EdgeInsets.only(top: 24.0),
        width: _screenSize.width,
        height: _screenSize.height / 4,
        child: Stack(
          //alignment: buttonSwingAnimation.value,
            alignment: Alignment.centerLeft,
            children: <Widget>[
              ListView(
                padding: const EdgeInsets.all(20.0),
                children: <Widget>[
                  Text(
                    church.name,
                    style: new TextStyle( fontWeight: FontWeight.bold,
                        fontSize: 24.0),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 12.0, top: 6.0),
                    child: Text( church.city,
                        style: new TextStyle( fontSize: 20.0)
                    ),
                  ),
                  CountyFlagView(church.country,
                    width: 36.0,
                    height: 36.0,)
                ],
              )
            ]
        )
    );
  }

  Widget _buildBarButton(BuildContext context){
    return Row(
      children: <Widget>[
        EditButton(
          onPressed: () {
            Navigator.of(context).push(
                new MaterialPageRoute(
                    builder: (context) => new EditChurchScreen(church, token)
                ));
          },
          screenSize: _screenSize,
        ),
      ],
    );
  }

}