import 'package:flutter/material.dart';

class ProcessDialog extends StatelessWidget{

  final String text;

  ProcessDialog({@required this.text});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            new CircularProgressIndicator(),
            new Text(text),
          ],
        ),
      )
    );
  }

}