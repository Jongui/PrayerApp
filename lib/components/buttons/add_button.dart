import 'package:flutter/material.dart';
import 'package:prayer_app/localizations.dart';

class AddButton extends StatelessWidget {

  final VoidCallback onPressed;
  final Size screenSize;

  AddButton({@required this.onPressed, this.screenSize});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: screenSize.height / 20,
        width: screenSize.width / 4,
        margin: EdgeInsets.only(left: 18.0),
        padding: const EdgeInsets.all(0.0),
        decoration: new BoxDecoration(
            border: new Border.all(color: Colors.deepPurple[200]),
            borderRadius: BorderRadius.circular(6.25),
            shape: BoxShape.rectangle
        ),
        child: RaisedButton(
            onPressed: onPressed,
            elevation: 0.0,
            color: Colors.white30,
            disabledColor: Colors.blueGrey,
            splashColor: Colors.deepPurple[200],
            child: Text(AppLocalizations.of(context).add))
    );
  }

}