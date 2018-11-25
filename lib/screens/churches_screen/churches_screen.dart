import 'package:flutter/material.dart';
import 'package:prayer_app/model/church.dart';
import 'package:prayer_app/screens/churches_screen/views/church_view.dart';

class ChurchesScreen extends StatelessWidget {

  Church church;
  String token;

  ChurchesScreen(this.church, this.token);

  @override
  Widget build(BuildContext context) {
    return ChurchesScreenState(church, token);
  }

}

class ChurchesScreenState extends StatefulWidget {

  ChurchesScreenState(this.church, this.token, {Key key}) : super(key: key);
  Church church;
  String token;

  @override
  _ChurchesScreenState createState() => new _ChurchesScreenState();

}

class _ChurchesScreenState extends State<ChurchesScreenState>{

  Church _church;
  String _token;

  @override
  Widget build(BuildContext context) {
    _church = this.widget.church;
    _token = this.widget.token;
    return Scaffold(
      appBar: AppBar(
        title: Text('Prays App'),
      ),
      body: ChurchView(_church, _token),
    );
  }
}