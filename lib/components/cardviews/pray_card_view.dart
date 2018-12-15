import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prayer_app/components/views/pray_creator_view.dart';
import 'package:prayer_app/components/views/pray_rate_view.dart';
import 'package:prayer_app/localizations.dart';
import 'package:prayer_app/model/pray.dart';
import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/model/user_pray.dart';
import 'package:prayer_app/screens/edit_pray_screen/edit_pray_screen.dart';

class PrayCardView extends StatelessWidget{

  Pray pray;
  User user;
  UserPray userPray;

  PrayCardView({@required this.pray, @required this.userPray, @required this.user});

  @override
  Widget build(BuildContext context) {
    return PrayCardViewState(pray, userPray, user);
  }

}

class PrayCardViewState extends StatefulWidget {

  Pray pray;
  User user;
  UserPray userPray;
  PrayCardViewState(this.pray, this.userPray, this.user);

  _PrayCardViewState createState() => _PrayCardViewState(pray,userPray,user);

}

class _PrayCardViewState extends State<PrayCardViewState>{

  static final colors = [Colors.green, Colors.blue, Colors.red, Colors.yellow, Colors.deepPurple];

  Pray pray;
  User user;
  UserPray userPray;
  
  _PrayCardViewState(this.pray, this.userPray, this.user);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var formatterTo = new DateFormat('dd-MM-yyyy');
    String _subtitle = AppLocalizations.of(context).prayFromTo(formatterTo.format(pray.beginDate),
        formatterTo.format(pray.endDate));

    var rng = new Random();
    int index = rng.nextInt(colors.length);
    var textColor = colors[index];
    return GestureDetector(
      onTap: () {
      Navigator.of(context).push(
          new MaterialPageRoute(
              builder: (context) => EditPrayScreen(pray: pray,
              user: user,)
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