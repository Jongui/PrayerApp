import 'package:flutter/material.dart';
import 'package:prayer_app/localizations.dart';
import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/screens/add_pray_screen/add_pray_screen.dart';
import 'package:prayer_app/screens/prays_screen/views/prays_view.dart';

class PraysScreen extends StatefulWidget {
  User user;

  PraysScreen({@required this.user});

  @override
  _PraysScreenState createState() => _PraysScreenState(user);
}

class _PraysScreenState extends State<PraysScreen> {
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
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.only(right: 10.0),
            icon: Icon(
              Icons.add,
              size: 40.0,
            ),
            tooltip: AppLocalizations.of(context).addNew,
            onPressed: () {
              Navigator.of(context)
                  .push(new MaterialPageRoute(
                      builder: (context) => AddPrayScreen(
                            user: user,
                          )))
                  .whenComplete(onReload);
            },
          ),
        ],
      ),
      body: PrayView(
        user: user,
        token: user.token,
      ),
    );
  }

  onReload() {
    setState(() {});
  }
}
