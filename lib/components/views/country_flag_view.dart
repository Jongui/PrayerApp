import 'package:flutter/material.dart';
import 'package:prayer_app/resources/country_codes.dart';

class CountyFlagView extends StatelessWidget {

  String country;
  double width = 24.0;
  double height = 24.0;
  Color color = Colors.black;

  CountyFlagView({@required this.country, this.width, this.height, this.color});

  String _countryName;
  String _language;

  @override
  Widget build(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    _language = locale.languageCode;
    String assetString = "assets/countries_flags/" + country.toLowerCase() + ".png";
    _formatCountryName();

    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.only(left: 12.0, top: 6.0),
      child: Row(
        children: <Widget>[
          Image(image: AssetImage(assetString),
            alignment: Alignment.centerLeft,),
          FittedBox(
            child: Text(_countryName,
              style: TextStyle(color: color),
            ),
            fit: BoxFit.scaleDown,
          )],
      ),
    );
  }

  void _formatCountryName() {
    var code = countryCodes[0];
    if(code.containsKey(country.toUpperCase())){
      var _translations = code[country.toUpperCase()]["translations"];
      _countryName = _translations[_language.toLowerCase()];
    }
  }

}