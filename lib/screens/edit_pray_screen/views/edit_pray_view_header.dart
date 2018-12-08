import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prayer_app/localizations.dart';
import 'package:prayer_app/model/pray.dart';
import 'package:prayer_app/model/user.dart';

class EditPrayViewHeader extends StatelessWidget{

  Pray pray;
  User user;

  EditPrayViewHeader({@required this.pray, @required this.user});

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 180.0,
      decoration: new BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/pray.jpg"),
              fit: BoxFit.cover)
      ),
      child: new Column(
        children: <Widget>[
          _buildDetails(context),
          new Divider()
        ],
      ),
    );
  }

  Widget _buildDetails(BuildContext context){
    var formatterTo = new DateFormat('dd-MM-yyyy');
    String _subtitle = AppLocalizations.of(context).prayFromTo(formatterTo.format(pray.beginDate),
          formatterTo.format(pray.endDate));
    return Container(
      padding: EdgeInsets.only(top: 76.0),
      child: ListTile(
        title: Text(pray.description,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),),
        subtitle: Text(_subtitle,
            style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,),
        ),
      ),
    );
  }

}