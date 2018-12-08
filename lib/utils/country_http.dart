import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:prayer_app/model/country.dart';

class CountryHttp {
  static final CountryHttp _countryHttp = new CountryHttp._internal();


  HashMap<String, Country> _countryHash = HashMap();

  factory CountryHttp(){
    return _countryHttp;
  }

  CountryHttp._internal();

  Country countryOffline(String code){
    return _countryHash[code];
  }

  Future<Country> countryDescription(String code, String language) async{
    final response = await http.get("https://restcountries.eu/rest/v2/alpha/" + code,);
    Country ret = _countryHash[code];
    if(ret != null)
      return ret;
    try {
      var jsonVar = json.decode(response.body);
      if (response.statusCode == 200 && jsonVar != null) {
        ret = Country.fromJson(jsonVar, language);
        _countryHash[code] = ret;
        return ret;
      }
    } catch (e){
      return null;
    }
  }

}