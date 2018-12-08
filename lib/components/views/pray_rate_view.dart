import 'package:flutter/material.dart';
import 'package:prayer_app/localizations.dart';
import 'package:prayer_app/model/user_pray.dart';

class PrayRateView extends StatelessWidget{

  UserPray userPray;

  PrayRateView({@required this.userPray});

  @override
  Widget build(BuildContext context) {
    return PrayRateViewState(userPray);
  }
}

class PrayRateViewState extends StatefulWidget{

  UserPray userPray;

  PrayRateViewState(this.userPray);

  _PrayRateViewState createState() => _PrayRateViewState(userPray);

}

class _PrayRateViewState extends State<PrayRateViewState>{

  UserPray userPray;

  _PrayRateViewState(this.userPray);

  @override
  Widget build(BuildContext context) {
    Color _color = _calcRateColor(userPray);
    return Container(
      padding: EdgeInsets.only(right: 12.0),
      width: 96.0,
      child: Text(AppLocalizations.of(context).ratedByUser(userPray.rate),
          style: TextStyle(fontSize: 16.0,
            color: _color),
      )
    );
  }

  Color _calcRateColor(UserPray userPray){
    Color ret = Colors.black;
    if(userPray.rate == null){
      userPray.rate = 0;
    }
    if(userPray.rate < 2){
      ret = Colors.red;
    } else if (userPray.rate >= 2 && userPray.rate < 4){
      ret = Colors.orange;
    } else if (userPray.rate >= 4){
      ret = Colors.blue;
    }
    return ret;
  }

}