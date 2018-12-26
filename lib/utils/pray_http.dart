import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:prayer_app/model/pray.dart';
import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/resources/config.dart';

class PrayHttp {
  static final PrayHttp _prayHttp = PrayHttp._internal();

  HashMap<int, Pray> _prayHash = HashMap();

  factory PrayHttp(){
    return _prayHttp;
  }

  PrayHttp._internal();

  Future<http.Response> postPray(Pray pray, String token) async {
    final response =
    await http.post(serverIp + 'pray',
      headers: {
        "Content-Type": "application/json",
        "authorization": "Basic " + token
      },
      body: json.encode(pray),
    );
    return response;
  }

  Future<http.Response> putPray(Pray pray, String token) async{
    final response =
        await http.put(serverIp + 'pray/' + pray.idPray.toString(),
      headers: {
        "Content-Type": "application/json",
        "authorization": "Basic " + token
      },
      body: json.encode(pray),
    );
    return response;
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
    prays.sort((pray1, pray2) => pray1.description.compareTo(pray2.description));
    return prays;
  }

  Future<Pray> getPrayById(int idPray, String token) async{
    final response =
    await http.get(serverIp + 'pray/' + idPray.toString(),
      headers: {
        "Content-Type": "application/json",
        "authorization": "Basic " + token
      },
    );
    try{
      var prayJson = json.decode(response.body);
      if(response.statusCode == 200 && prayJson != null){
        Pray pray = Pray.fromJson(prayJson);
        _prayHash[pray.idPray] = pray;
        return pray;
      }
    } catch (e){
      return Pray();
    }
  }

}