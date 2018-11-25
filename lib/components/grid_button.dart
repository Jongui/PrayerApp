import 'package:flutter/material.dart';

class GridButton extends StatelessWidget {

  double buttonHeight, buttonWidth;
  Icon icon;
  Border border;
  EdgeInsetsGeometry padding;
  VoidCallback onPressed;
  EdgeInsetsGeometry buttonPadding;

  GridButton({this.buttonHeight, this.buttonWidth, this.icon, this.border, this.padding, this.onPressed, this.buttonPadding});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: buttonHeight,
      height: buttonWidth,
      padding: padding,
      //padding: const EdgeInsets.only(right: 28.0),//I used some padding without fixed width and height
      decoration: new BoxDecoration(
        shape: BoxShape.rectangle,
        border: border,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: RaisedButton(
        padding: buttonPadding,
        onPressed: onPressed,
        color: Colors.white,
        textColor: Colors.blueGrey,
        disabledColor: Colors.grey,
        splashColor: Colors.grey,
        elevation: 0.0,
        child: icon,
      ),
    );
  }

}