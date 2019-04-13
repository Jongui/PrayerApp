import 'package:flutter/material.dart';
import 'package:prayer_app/localizations.dart';

class DeleteButton extends StatelessWidget {

  final VoidCallback onPressed;
  final double height;
  final double width;

  DeleteButton({this.onPressed, this.height, this.width} );

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        margin: EdgeInsets.only(left: 18.0),
        padding: const EdgeInsets.all(0.0),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.red),
            borderRadius: BorderRadius.circular(6.25),
            shape: BoxShape.rectangle
        ),
        child: RaisedButton(
            onPressed: onPressed,
            elevation: 0.0,
            color: Colors.red,
            textColor: Colors.white,
            disabledColor: Colors.redAccent,
            splashColor: Colors.red,
            child: Text(AppLocalizations.of(context).delete))
    );
  }

}
