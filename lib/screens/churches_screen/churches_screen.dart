import 'package:flutter/material.dart';
import 'package:prayer_app/localizations.dart';
import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/screens/add_church_screen/add_church_screen.dart';
import 'package:prayer_app/screens/churches_screen/views/churches_view.dart';

class ChurchesScreen extends StatefulWidget {
  User user;

  ChurchesScreen({@required this.user});

  @override
  _ChurchesScreenState createState() => new _ChurchesScreenState();
}

class _ChurchesScreenState extends State<ChurchesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).title),
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.only(right: 10.0),
            icon: Icon(Icons.add,
            size: 40.0,),
            tooltip: AppLocalizations.of(context).addNew,
            onPressed: () {
              Navigator.of(context)
                  .push(new MaterialPageRoute(
                      builder: (context) => AddChurchScreen(
                            user: this.widget.user,
                          )))
                  .whenComplete(onReload);
            },
          ),
        ],
      ),
      body: ChurchesView(user: this.widget.user),
    );
  }

  onReload() async {
    setState(() {});
  }
}
