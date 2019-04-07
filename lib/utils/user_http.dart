import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:prayer_app/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:prayer_app/resources/config.dart';
import 'package:prayer_app/utils/firebase_messaging_utils.dart';

class UserHttp {
  static final UserHttp _userHttp = new UserHttp._internal();

  HashMap<int, User> _userHash = HashMap();

  factory UserHttp() {
    return _userHttp;
  }

  UserHttp._internal();

  Future<User> createUser(FirebaseUser firebaseUser) async {
    String token = await firebaseUser.getIdToken(refresh: false);
    User user = User(
        email: firebaseUser.email,
        userName: firebaseUser.displayName,
        city: "Not defined",
        country: "ND");
    final response = await http.post(serverIp + 'user',
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Basic " + token,
        },
        body: json.encode(user),
        encoding: Encoding.getByName("utf-8"));
    try {
      var jsonVar = json.decode(response.body);
      if (response.statusCode == 201 && jsonVar != null) {
        User ret = User.fromJson(jsonVar);
        ret.token = token;
        FirebaseMessagingUtils().subscribeToUserTopic(ret.idUser);
        return ret;
      }
    } catch (e) {
      return null;
    }
  }

  Future<User> fetchUser(FirebaseUser firebaseUser) async {
    String token = await firebaseUser.getIdToken(refresh: false);
    final response = await http
        .get(serverIp + 'user/email/' + firebaseUser.email + '/', headers: {
      "Content-Type": "application/json",
      "authorization": "Basic " + token
    });
    try {
      var jsonVar = json.decode(response.body);
      var value = jsonVar['value'];
      var userJson = value[0];
      if (response.statusCode == 200 && userJson != null) {
        User user = User.fromJson(userJson);
        user.token = token;
        return user;
      }
    } catch (e) {
      return null;
    }
  }

  Future<User> getUser(int idUser, String token) async {
    final response = await http.get(serverIp + 'user/' + idUser.toString(),
        headers: {
          "Content-Type": "application/json",
          "authorization": "Basic " + token
        });
    try {
      var userJson = json.decode(response.body);
      if (response.statusCode == 200 && userJson != null) {
        User user = User.fromJson(userJson);
        _userHash[user.idUser] = user;
        return user;
      }
    } catch (e) {
      return User();
    }
  }

  Future<int> putUser(User user, {String token}) async {
    if (user.token != null) {
      token = user.token;
    }
    final response = await http.put(
      serverIp + 'user/' + user.idUser.toString(),
      headers: {
        "Content-Type": "application/json",
        "authorization": "Basic " + token
      },
      body: json.encode(user),
    );
    return response.statusCode;
  }

  User getOfflineUser(int idUser) {
    return _userHash[idUser];
  }

  Future<List<User>> getUsersByChurch(int idChurch, String token) async {
    List<User> users = [];
    final response = await http
        .get(serverIp + 'user/church/' + idChurch.toString(), headers: {
      "Content-Type": "application/json",
      "authorization": "Basic " + token
    });
    try {
      var jsonVar = json.decode(response.body);
      List value = jsonVar['value'];
      users = value.map((userJson) => User.fromJson(userJson)).toList();
      for (int i = 0; i < users.length; i++) {
        User user = users.elementAt(i);
        _userHash[user.idUser] = user;
      }
    } catch (e) {
      return users;
    }
    users.sort((user1, user2) => user1.userName.compareTo(user2.userName));
    return users;
  }

  Future<List<User>> getAllUsers(String token) async {
    List<User> users = [];
    final response = await http.get(serverIp + 'user/' + '?size=20', headers: {
      "Content-Type": "appliation/json",
      "Authorization": "Basic " + token
    });
    try {
      var jsonVar = json.decode(response.body);
      List value = jsonVar['value'];
      users = value.map((userJson) => User.fromJson(userJson)).toList();
      for (int i = 0; i < users.length; i++) {
        User user = users.elementAt(i);
        _userHash[user.idUser] = user;
      }
    } catch (e) {
      return users;
    }
    users.sort((user1, user2) => user1.userName.compareTo(user2.userName));
    return users;
  }

  Future<List<User>> getUsersByUserName(String pattern, String token) async {
    List<User> users = [];
    final response = await http.get(
      serverIp + 'user/userName/' + pattern + '?size=20',
      headers: {
        "Content-Type": "appliation/json",
        "Authorization": "Basic " + token,
      },
    );
    try {
      var jsonVar = json.decode(response.body);
      List value = jsonVar['value'];
      users = value.map((userJson) => User.fromJson(userJson)).toList();
      for (int i = 0; i < users.length; i++) {
        User user = users.elementAt(i);
        _userHash[user.idUser] = user;
      }
    } catch (e) {
      return users;
    }
    users.sort((user1, user2) => user1.userName.compareTo(user2.userName));
    return users;
  }
}
