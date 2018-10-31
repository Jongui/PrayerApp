import 'dart:async';
import 'dart:convert';

import 'package:prayer_app/model/church.dart';
import 'package:http/http.dart' as http;

class ChurchHttp{
  static final ChurchHttp _churchHttp = new ChurchHttp._internal();

  factory ChurchHttp(){
    return _churchHttp;
  }

  ChurchHttp._internal();

  Future<Church> fetchChurch(int idChurch, String token) async {
    String url = 'http://192.168.1.9:8080/api/v1/church/' + idChurch.toString();
    final response =
        await http.get(url,
          headers: {"authorization": "Basic " + token}
        );
    try {
      var jsonVar = json.decode(response.body);
      if (response.statusCode == 200 && jsonVar != null) {
        print(response.body);
        return Church.fromJson(jsonVar);
      }
    } catch (e){
      return null;
    }
  }

}