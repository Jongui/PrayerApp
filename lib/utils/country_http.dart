import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class CountryHttp {
  static final CountryHttp _countryHttp = new CountryHttp._internal();

  factory CountryHttp(){
    return _countryHttp;
  }

  CountryHttp._internal();

  Future<dynamic> countryDescription(String code) async{
    final response = await http.get("https://restcountries.eu/rest/v2/alpha/" + code,);
    try {
      var jsonVar = json.decode(response.body);
      if (response.statusCode == 200 && jsonVar != null) {
        return jsonVar["name"];
      }
    } catch (e){
      return null;
    }
  }

}