import 'package:flutter/material.dart';
import 'package:prayer_app/model/pray.dart';

class EditPrayScreen extends StatelessWidget{

  String token;
  Pray pray;

  EditPrayScreen({@required this.token, @required this.pray});

  @override
  Widget build(BuildContext context) {
    return EditPrayScreenState(token, pray);
  }

}

class EditPrayScreenState extends StatefulWidget{
  String token;
  Pray pray;
  EditPrayScreenState(this.token, this.pray);

  _EditPrayScreenState createState() => _EditPrayScreenState(token, pray);
}

class _EditPrayScreenState extends State<EditPrayScreenState>{
  String token;
  Pray pray;
  _EditPrayScreenState(this.token, this.pray);

  @override
  Widget build(BuildContext context) {

    return Text('Edit Pray Screen');
  }
}