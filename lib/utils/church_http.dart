import 'dart:async';
import 'dart:convert';

import 'package:prayer_app/model/church.dart';
import 'package:http/http.dart' as http;
import 'package:prayer_app/resources/config.dart';

class ChurchHttp {
  static final ChurchHttp _churchHttp = new ChurchHttp._internal();

  factory ChurchHttp(){
    return _churchHttp;
  }

  ChurchHttp._internal();

  Future<Church> fetchChurch(int idChurch, String token) async {
    String url = serverIp + 'church/' + idChurch.toString();
    final response =
    await http.get(url,
        headers: {"authorization": "Basic " + token}
    );
    try {
      var jsonVar = json.decode(response.body);
      if (response.statusCode == 200 && jsonVar != null) {
        return Church.fromJson(jsonVar);
      }
    } catch (e) {
      return Church();
    }
  }

  Future<int> postChurch(Church church, String token) async {
    final response =
    await http.post(serverIp + 'church',
      headers: {
        "Content-Type": "application/json",
        "authorization": "Basic " + token
      },
      body: json.encode(church),
    );
    return response.statusCode;
  }

  Future<int> putChurch(Church church, String token) async{
    final response =
    await http.put(serverIp + 'church/' + church.idChurch.toString(),
      headers: {
        "Content-Type": "application/json",
        "authorization": "Basic " + token
      },
      body: json.encode(church),
    );
    return response.statusCode;
  }

  Future<List<Church>> getChurches() async{
    List<Church> churches = [];
    final response =
    await http.get(serverIp + 'church/',
      headers: {
        "Content-Type": "application/json"
      },
    );
    try {
      var jsonVar = json.decode(response.body);
      List value = jsonVar['value'];
      churches = value.map((churchJson) => Church.fromJson(churchJson)).toList();
    } catch (e){
      return churches;
    }
    return churches;
  }

}