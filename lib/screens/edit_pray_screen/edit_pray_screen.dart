import 'package:flutter/material.dart';
import 'package:prayer_app/model/pray.dart';
import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/screens/edit_pray_screen/views/edit_pray_view.dart';

class EditPrayScreen extends StatelessWidget {

  Pray pray;
  User user;

  EditPrayScreen({@required this.pray, @required this.user});

  @override
  Widget build(BuildContext context) {
    return EditPrayScreenState(pray, user);
  }

}

class EditPrayScreenState extends StatefulWidget {

  EditPrayScreenState(this.pray, this.user, {Key key}) : super(key: key);
  Pray pray;
  User user;

  @override
  _EditPrayScreenState createState() => _EditPrayScreenState(pray, user);

}

class _EditPrayScreenState extends State<EditPrayScreenState>{

  Pray pray;
  User user;

  _EditPrayScreenState(this.pray, this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit your pray'),
      ),
      body: EditPrayView(pray: pray,
        user: user,),
    );

  }

}