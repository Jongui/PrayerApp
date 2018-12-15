import 'package:flutter/material.dart';
import 'package:prayer_app/components/buttons/float_add_button.dart';
import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/screens/add_pray_screen/add_pray_screen.dart';
import 'package:prayer_app/screens/prays_screen/views/prays_view.dart';

class PraysScreen extends StatelessWidget {

  User user;

  PraysScreen(this.user);

  @override
  Widget build(BuildContext context) {
    return PraysScreenState(user);
  }

}

class PraysScreenState extends StatefulWidget {

  PraysScreenState(this.user, {Key key}) : super(key: key);
  User user;

  @override
  _PraysScreenState createState() => _PraysScreenState();

}

class _PraysScreenState extends State<PraysScreenState>{

  User _user;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _user = this.widget.user;
    return Scaffold(
      appBar: AppBar(
        title: Text('Prays'),
      ),
      body: PrayView(_user),
      floatingActionButton: FloatAddButton(
        onPressed:  () {
          Navigator.of(context).push(
              new MaterialPageRoute(
                  builder: (context) => AddPrayScreen(user: _user,)
              )).whenComplete(onReload);
        },
      ),
    );
  }

  onReload(){
    setState(() {

    });
  }

}