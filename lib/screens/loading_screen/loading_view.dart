import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 24.0, left: 84.0),
        child:CircularProgressIndicator()
    );
  }
}