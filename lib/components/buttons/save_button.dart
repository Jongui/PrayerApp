import 'package:flutter/material.dart';
import 'package:prayer_app/localizations.dart';

class SaveButton extends StatelessWidget {

  final VoidCallback onPressed;
  final double height;
  final double width;

  SaveButton({this.onPressed, this.height, this.width} );

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        margin: EdgeInsets.only(left: 18.0),
        padding: const EdgeInsets.all(0.0),
        decoration: new BoxDecoration(
            border: new Border.all(color: Colors.green),
            borderRadius: BorderRadius.circular(6.25),
            shape: BoxShape.rectangle
        ),
        child: RaisedButton(
            onPressed: onPressed,
            elevation: 0.0,
            color: Colors.green,
            textColor: Colors.white,
            disabledColor: Colors.greenAccent,
            splashColor: Colors.green,
            child: Text(AppLocalizations.of(context).save))
    );
  }

}
