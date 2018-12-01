import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prayer_app/components/views/pray_creator_view.dart';
import 'package:prayer_app/components/views/pray_rate_view.dart';
import 'package:prayer_app/model/pray.dart';
import 'package:prayer_app/model/user_pray.dart';
import 'package:prayer_app/screens/one_pray_screen/one_pray_screen.dart';

class PrayCardView extends StatelessWidget{

  Pray pray;
  UserPray userPray;

  PrayCardView({@required this.pray, @required this.userPray});

  @override
  Widget build(BuildContext context) {
    return PrayCardViewState(pray, userPray);
  }

}

class PrayCardViewState extends StatefulWidget {

  Pray pray;
  UserPray userPray;
  PrayCardViewState(this.pray, this.userPray);

  _PrayCardViewState createState() => _PrayCardViewState(pray,userPray);

}

class _PrayCardViewState extends State<PrayCardViewState>{

  static final colors = [Colors.green, Colors.blue, Colors.red, Colors.yellow, Colors.deepPurple];

  Pray pray;
  UserPray userPray;
  String _subtitle;

  _PrayCardViewState(this.pray, this.userPray);

  @override
  void initState() {
    var formatterTo = new DateFormat('dd-MM-yyyy');
    _subtitle = 'Pray from ' + formatterTo.format(pray.beginDate)
      + ' to ' + formatterTo.format(pray.endDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var rng = new Random();
    int index = rng.nextInt(colors.length);
    var textColor = colors[index];
    return GestureDetector(
      onTap: () {
      Navigator.of(context).push(
          new MaterialPageRoute(
              builder: (context) => OnePrayScreen(pray: pray,)
          ));
      },
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              child: ListTile(
                leading: Icon(Icons.album,
                  color: textColor,
                  size: 40.0,),
                title: Text(pray.description),
                subtitle: Text(_subtitle),
              ),
            ),
            Container(
              color: Colors.grey[100],
              child: ButtonTheme.bar( // make buttons use the appropriate styles for cards
                child: Row(
                  children: <Widget>[
                    ButtonBar(
                      children: <Widget>[
                        PrayCreatorView(idCreator: pray.idUser,),
                        PrayRateView(userPray: userPray),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}