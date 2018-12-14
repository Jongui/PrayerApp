import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prayer_app/components/views/country_flag_view.dart';
import 'package:prayer_app/localizations.dart';
import 'package:prayer_app/model/church.dart';
import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/screens/edit_church_screen/edit_church_screen.dart';

class ChurchCardView extends StatelessWidget {

  Church church;
  User user;

  ChurchCardView({@required this.church, @required this.user});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(user.idUser == church.createdBy){
          Navigator.of(context).push(
            new MaterialPageRoute(
              builder: (context) => EditChurchScreen(church: church,
              user: user,)
            )
          );
        }
      },
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: buildCardComponents(context),
        )
      )
    );
  }

  List<Widget> buildCardComponents(BuildContext context){
    List<Widget> ret = [];
    ret.add(Container(
      height: 192.0,
      decoration: new BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/church_background.jpg"),
              fit: BoxFit.cover)
      ),
      )
    );
    ret.add(
      Container(
        color: Colors.grey[100],
        child: ListTile(
          title: Text(church.name,
            style: TextStyle(color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
          ),
          subtitle: CountyFlagView(country: church.country,
            width: 36.0,
            height: 36.0,),
        ),
      )
    );
    if(user.idUser == church.createdBy){
      ret.add(
          Container(
            padding: EdgeInsets.only(right: 14.0, bottom: 8.0),
            color: Colors.grey[100],
            child: ButtonTheme.bar( // make buttons use the appropriate styles for cards
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  ButtonBar(
                    children: <Widget>[
                      Icon(FontAwesomeIcons.edit),
                      Text(AppLocalizations.of(context).edit,
                        style: TextStyle(fontSize: 18.0),)
                    ],
                  )
                ],
              ),
            ),
          )
      );
    }
    return ret;
  }

}