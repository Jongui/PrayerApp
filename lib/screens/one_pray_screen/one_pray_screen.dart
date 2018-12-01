import 'package:flutter/material.dart';
import 'package:prayer_app/model/pray.dart';

class OnePrayScreen extends StatelessWidget {

  Pray pray;

  OnePrayScreen({@required this.pray});

  @override
  Widget build(BuildContext context) {
    return OnePrayScreenState(pray);
  }

}

class OnePrayScreenState extends StatefulWidget {

  OnePrayScreenState(this.pray, {Key key}) : super(key: key);
  Pray pray;

  @override
  _OnePrayScreenState createState() => _OnePrayScreenState(pray);

}

class _OnePrayScreenState extends State<OnePrayScreenState>{

  Pray pray;

  _OnePrayScreenState(this.pray);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pray view'),
      ),
      body: Text(pray.description),
    );
  }

}