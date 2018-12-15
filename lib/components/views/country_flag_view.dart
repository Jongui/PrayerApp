import 'package:flutter/material.dart';
import 'package:prayer_app/model/country.dart';
import 'package:prayer_app/utils/country_http.dart';

class CountyFlagView extends StatelessWidget {

  String country;
  double width = 24.0;
  double height = 24.0;
  Color color = Colors.black;

  CountyFlagView({@required this.country, this.width, this.height, this.color});

  @override
  Widget build(BuildContext context) {
    return CountryFlagViewState(country, width, height, color);
  }

}

class CountryFlagViewState extends StatefulWidget {

  String country;
  double width;
  double height;
  Color color;
  CountryFlagViewState(this.country, this.width, this.height, this.color);

  _CountryFlagViewState createState() => _CountryFlagViewState(country, width, height, color);

}

class _CountryFlagViewState extends State<CountryFlagViewState>{

  String country;
  double width;
  double height;
  Color color;

  String _countryName;
  String _language;

  _CountryFlagViewState(this.country, this.width, this.height, this.color);

  @override
  void initState() {
    if(country == null)
      country = 'de';
    _countryName = country;
    _language = "en";
    _handleCountryInfoRequest();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    _language = locale.languageCode;
    String assetString = "assets/countries_flags/" + country.toLowerCase() + ".png";
    if(_countryName == null)
      _countryName = "Not defined";
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.only(left: 12.0, top: 6.0),
      child: Row(
        children: <Widget>[
          Image(image: AssetImage(assetString),
            alignment: Alignment.centerLeft,),
          Text(_countryName,
            style: TextStyle(color: color, fontSize: 18.0),
          )],
      ),
    );
  }

  void _handleCountryInfoRequest() async {
    Country countryObject = CountryHttp().countryOffline(country);
    if(countryObject == null)
      countryObject = await CountryHttp().countryDescription(country, _language);
    setState(() {
      _countryName = countryObject.name;
    });
  }

}