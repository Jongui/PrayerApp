import 'package:flutter/material.dart';
import 'package:prayer_app/components/buttons/float_add_button.dart';
import 'package:prayer_app/localizations.dart';
import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/screens/add_pray_screen/add_pray_screen.dart';
import 'package:prayer_app/screens/prays_screen/views/prays_view.dart';

class PraysScreen extends StatelessWidget {

  User user;

  PraysScreen({@required this.user});

  @override
  Widget build(BuildContext context) {
    return PraysScreenState(user);
  }

}

class PraysScreenState extends StatefulWidget {

  PraysScreenState(this.user,{Key key}) : super(key: key);
  User user;

  @override
  _PraysScreenState createState() => _PraysScreenState(user);

}

class _PraysScreenState extends State<PraysScreenState>{

  User user;

  _PraysScreenState(this.user);

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).prays),
      ),
      body: PrayView(user: user,
        token: user.token,),
      floatingActionButton: FloatAddButton(
        bottomMargin: 80.0,
        onPressed:  () {
          Navigator.of(context).push(
              new MaterialPageRoute(
                  builder: (context) => AddPrayScreen(user: user,)
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