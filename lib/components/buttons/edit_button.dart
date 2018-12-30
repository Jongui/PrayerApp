import 'package:flutter/material.dart';
import 'package:prayer_app/localizations.dart';

class EditButton extends StatelessWidget {

  final VoidCallback onPressed;
  final Size screenSize;

  EditButton({this.onPressed, this.screenSize});

  @override
  Widget build(BuildContext context) {
    double _height = screenSize != null ? screenSize.height : 500.0;
    double _width = screenSize != null ? screenSize.width : 500.0;
    return Container(
        height: _height / 20,
        width: _width / 4,
        margin: EdgeInsets.only(left: 18.0),
        padding: const EdgeInsets.all(0.0),
        decoration: new BoxDecoration(
            border: new Border.all(color: Colors.blue),
            borderRadius: BorderRadius.circular(6.25),
            shape: BoxShape.rectangle
        ),
        child: RaisedButton(
            onPressed: onPressed,
            elevation: 0.0,
            color: Colors.white30,
            disabledColor: Colors.blueGrey,
            splashColor: Colors.blue,
            child: Text(AppLocalizations.of(context).edit))
    );
  }

}
