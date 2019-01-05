import 'package:flutter/material.dart';

class SmallInputFieldArea extends StatelessWidget{
  final TextEditingController controller;
  SmallInputFieldArea({this.controller});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        obscureText: false,
        controller: controller,
        decoration: InputDecoration(
          icon: Icon(
            Icons.keyboard,
            color: Colors.blue,
          ),

        ));
  }

}