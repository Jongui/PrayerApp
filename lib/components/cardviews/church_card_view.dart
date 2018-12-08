import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prayer_app/components/views/country_flag_view.dart';
import 'package:prayer_app/model/church.dart';
import 'package:prayer_app/screens/edit_church_screen/edit_church_screen.dart';

class ChurchCardView extends StatelessWidget {

  Church church;
  String token;

  ChurchCardView({@required this.church, @required this.token});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
            new MaterialPageRoute(
                builder: (context) => EditChurchScreen(church: church,
                  token: token,)
            ));
      },
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 192.0,
              decoration: new BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/church_background.jpg"),
                      fit: BoxFit.cover)
              ),
            ),
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
            ),
          ]
        )
      )
    );
  }
}