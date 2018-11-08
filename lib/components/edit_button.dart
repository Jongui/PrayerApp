import 'package:flutter/material.dart';

class EditButton extends StatelessWidget {

  final VoidCallback onPressed;
  final Size screenSize;

  EditButton({this.onPressed, this.screenSize});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: screenSize.height / 20,
        width: screenSize.width / 4,
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
            child: Text('Edit'))
    );
  }

}
