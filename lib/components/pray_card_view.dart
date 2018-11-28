

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prayer_app/model/pray.dart';

class PrayCardView extends StatelessWidget{

  Pray pray;

  PrayCardView({@required this.pray});

  @override
  Widget build(BuildContext context) {
    return PrayCardViewState(pray);
  }

}

class PrayCardViewState extends StatefulWidget {

  Pray pray;
  PrayCardViewState(this.pray);

  _PrayCardViewState createState() => _PrayCardViewState(pray);

}

class _PrayCardViewState extends State<PrayCardViewState>{

  Pray pray;
  String _subtitle;

  _PrayCardViewState(this.pray);

  @override
  void initState() {
    var formatterTo = new DateFormat('dd-MM-yyyy');
    _subtitle = 'Pray from ' + formatterTo.format(pray.beginDate)
      + ' to ' + formatterTo.format(pray.endDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.album),
            title: Text(pray.description),
            subtitle: Text(_subtitle),
          ),
          ButtonTheme.bar( // make buttons use the appropriate styles for cards
            child: ButtonBar(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(right: 12.0),
                  child: FlatButton(
                    child: const Text('Edit',
                    style: TextStyle(fontSize: 18.0),),
                    onPressed: () { /* ... */ },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}