import 'package:flutter/material.dart';

class SmallInputFieldArea extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  SmallInputFieldArea({this.controller, this.focusNode});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        focusNode: focusNode,
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
