import 'package:flutter/material.dart';

class CountyFlagView extends StatelessWidget {

  String country;
  double width = 24.0;
  double height = 24.0;
  Color color = Colors.black;

  CountyFlagView(this.country,{ this.width, this.height, this.color});

  @override
  Widget build(BuildContext context) {
    if(country == null)
      country = 'de';
    String assetString = "assets/countries_flags/" + country.toLowerCase() + ".png";
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.only(left: 12.0, top: 6.0),
      child: Row(
        children: <Widget>[
          Image(image: AssetImage(assetString),
            alignment: Alignment.centerLeft,),
          Text(country,
            style: TextStyle(color: color, fontSize: 18.0),
          )],
      ),
    );
  }

}