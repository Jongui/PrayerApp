import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:prayer_app/model/pray.dart';
import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/model/user_pray.dart';
import 'package:prayer_app/resources/config.dart';

class UserPrayHttp {

  static final UserPrayHttp _userPrayHttp = new UserPrayHttp._internal();

  factory UserPrayHttp(){
    return _userPrayHttp;
  }

  UserPrayHttp._internal();

  Future<http.Response> postUserPray(User user, Pray pray, DateTime acceptanceDate, DateTime endDate) async {
    UserPray userPray = UserPray(
      idUser:  user.idUser,
      idPray: pray.idPray,
      acceptanceDate: acceptanceDate,
      endDate: endDate,
      rate: 0,
    );
    final response =
        await http.post(serverIp + 'userPray',
      headers: {
        "Content-Type": "application/json",
        "authorization": "Basic " + user.token
      },
      body: json.encode(userPray),
    );
    return response;
  }

  Future<List<UserPray>> getUserPrayByUser(int idUser, String token) async {
    List<UserPray> prays = [];
    final response = await http.get(serverIp + 'userPray/user/' + idUser.toString(),
        headers: {
          "Content-Type": "application/json",
          "authorization": "Basic " + token
        });
    try {
      var jsonVar = json.decode(response.body);
      List value = jsonVar['value'];
      prays = value.map((userPrayJson) => UserPray.fromJson(userPrayJson)).toList();
    } catch (e){
      return prays;
    }
    return prays;
  }

}