import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:prayer_app/model/pray.dart';
import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/resources/config.dart';

class PrayHttp {
  static final PrayHttp _prayHttp = new PrayHttp._internal();

  factory PrayHttp(){
    return _prayHttp;
  }

  PrayHttp._internal();

  Future<int> postPray(Pray pray, String token) async {
    final response =
    await http.post(serverIp + 'pray',
      headers: {
        "Content-Type": "application/json",
        "authorization": "Basic " + token
      },
      body: json.encode(pray),
    );
    return response.statusCode;
  }

  Future<List<Pray>> getPraysByUser(User user) async {
    List<Pray> prays = [];
    final response =
        await http.get(serverIp + 'pray/user/' + user.idUser.toString(),
      headers: {
        "Content-Type": "application/json",
        "authorization": "Basic " + user.token
      },
    );
    try {
      var jsonVar = json.decode(response.body);
      List value = jsonVar['value'];
      prays = value.map((prayJson) => Pray.fromJson(prayJson)).toList();
    } catch (e){
      return prays;
    }
    return prays;
  }

}