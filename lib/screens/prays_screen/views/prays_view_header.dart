import 'package:flutter/material.dart';
import 'package:prayer_app/components/add_button.dart';
import 'package:prayer_app/model/user.dart';

class PrayViewHeader extends StatelessWidget {

  User user;

  Size _screenSize;

  PrayViewHeader(this.user);

  @override
  Widget build(BuildContext context) {
    return _buildBarButton(context);
  }

  Widget _buildBarButton(BuildContext context){
    _screenSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: 24.0, bottom: 24.0),
      child: Row(
        children: <Widget>[
          AddButton(
            onPressed: () {

            },
            screenSize: _screenSize,
          ),
        ],
      ),
    );
  }

}