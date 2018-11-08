import 'package:flutter/material.dart';

class InputFieldArea extends StatelessWidget {
  final String hint;
  final String labelText;
  final bool obscure;
  final IconData icon;
  final TextEditingController controller;
  InputFieldArea({this.hint, this.obscure, this.icon, this.controller, this.labelText});
  @override
  Widget build(BuildContext context) {
    return (new Container(
      decoration: new BoxDecoration(
        border: new Border(
          bottom: new BorderSide(
            width: 0.5,
            color: Colors.blue,
          ),
          top:  new BorderSide(
            width: 0.5,
            color: Colors.blue,
          ),
          left:  new BorderSide(
            width: 0.5,
            color: Colors.blue,
          ),
          right:  new BorderSide(
            width: 0.5,
            color: Colors.blue,
          ),
        ),
          borderRadius: BorderRadius.circular(6.25),
          shape: BoxShape.rectangle
      ),
      child: new TextFormField(
        obscureText: obscure,
        style: const TextStyle(
          color: Colors.blueGrey,
        ),
        controller: controller,
        decoration: new InputDecoration(
          icon: new Icon(
            icon,
            color: Colors.blue,
          ),
          border: InputBorder.none,
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.blueGrey, fontSize: 15.0),
          labelText: labelText != null ? labelText : '',
          labelStyle: const TextStyle(color: Colors.blue, fontSize: 18.0),
          contentPadding: const EdgeInsets.only(
              top: 30.0, right: 30.0, bottom: 30.0, left: 5.0),
        ),
      ),
    ));
  }
}