import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prayer_app/model/church.dart';
import 'package:prayer_app/localizations.dart';

class SingleChurchViewHeader extends StatelessWidget{

  Church church;

  SingleChurchViewHeader({@required this.church});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.0,
      decoration: new BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/church_background.jpg"),
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
    var formatterTo = DateFormat('dd-MM-yyyy');
    String _subtitle = AppLocalizations.of(context).createdAt(formatterTo.format(church.createdAt));
    return Container(
      padding: EdgeInsets.only(top: 76.0),
      child: ListTile(
        title: Text(church.name,
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