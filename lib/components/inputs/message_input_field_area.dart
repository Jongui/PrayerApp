import 'package:flutter/material.dart';

class MessageInputFieldArea extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onMessageSend;
  MessageInputFieldArea({@required this.onMessageSend, this.controller});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: TextFormField(
            maxLines: null,
            keyboardType: TextInputType.multiline,
            obscureText: false,
            controller: controller,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                    icon: Icon(
                      Icons.send,
                      color: Colors.blue,
                    ),
                    onPressed: onMessageSend))));
  }
}
