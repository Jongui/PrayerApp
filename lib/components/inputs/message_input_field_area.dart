import 'package:flutter/material.dart';

class MessageInputFieldArea extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onMessageSend;
  MessageInputFieldArea({@required this.onMessageSend, this.controller});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        obscureText: false,
        controller: controller,
        decoration: InputDecoration(
            suffixIcon: IconButton(
                icon: Icon(
                  Icons.send,
                  color: Colors.blue,
                ),
                onPressed: onMessageSend)));
  }
}
