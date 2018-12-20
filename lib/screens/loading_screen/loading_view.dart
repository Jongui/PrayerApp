import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment(0.0, 0.0),
        child:CircularProgressIndicator()
    );
  }
}