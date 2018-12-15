import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:prayer_app/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:prayer_app/resources/config.dart';

class UserHttp{
  static final UserHttp _userHttp = new UserHttp._internal();

  HashMap<int, User> _userHash = HashMap();

  factory UserHttp(){
    return _userHttp;
  }

  UserHttp._internal();

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User> createUser(FirebaseUser firebaseUser) async {
    User user = User( email: firebaseUser.email,
        userName: firebaseUser.displayName,
        city: "Not defined",
        country: "ND");
    final response = await http.post(serverIp + 'user',
        headers: {
          "Content-Type": "application/json"
        },
        body: json.encode(user),
        encoding: Encoding.getByName("utf-8")
    );
    try {
      var jsonVar = json.decode(response.body);
      if (response.statusCode == 201 && jsonVar != null) {
        return User.fromJson(jsonVar);
      }
    } catch (e){
      return null;
    }
  }

  Future<User> fetchUser(FirebaseUser firebaseUser) async {
    final response =
    await http.get(serverIp + 'user/email/' + firebaseUser.email
        + '/');
    try {
      var jsonVar = json.decode(response.body);
      var value = jsonVar['value'];
      var userJson = value[0];
      if (response.statusCode == 200 && userJson != null) {
        return User.fromJson(userJson);
      }
    } catch (e){
      return null;
    }
  }

  Future<User> getUser(int idUser) async {
    final response = await http.get(serverIp + 'user/' + idUser.toString());
    try{
      var userJson = json.decode(response.body);
      if(response.statusCode == 200 && userJson != null){
        User user = User.fromJson(userJson);
        _userHash[user.idUser] = user;
        return user;
      }
    } catch(e){
      return User();
    }
  }

  Future<FirebaseUser> performFirebaseSignIn() async{
    // Attempt to get the currently authenticated user
    GoogleSignInAccount currentUser = _googleSignIn.currentUser;
    if (currentUser == null) {
      // Attempt to sign in without user interaction
      currentUser = await _googleSignIn.signInSilently();
    }
    if (currentUser == null) {
      // Force the user to interactively sign in
      currentUser = await _googleSignIn.signIn();
    }
    GoogleSignInAuthentication googleAuth = await currentUser.authentication;
    FirebaseUser firebaseUser = await _auth.signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    print("signed in " + firebaseUser.displayName);
    return firebaseUser;
  }

  Future<int> putUser(User user) async{
    final response =
        await http.put(serverIp + 'user/' + user.idUser.toString(),
          headers: {
            "Content-Type": "application/json",
            "authorization": "Basic " + user.token
          },
          body: json.encode(user),
        );
    return response.statusCode;
  }

  User getOfflineUser(int idUser){
    return _userHash[idUser];
  }

  Future<List<User>> getUsersByChurch(int idChurch, String token) async{
    List<User> users = [];
    final response = await http.get(serverIp + 'user/church/' + idChurch.toString(),
      headers: {
        "Content-Type": "application/json",
        "authorization": "Basic " + token
      }
    );
    try {
      var jsonVar = json.decode(response.body);
      List value = jsonVar['value'];
      users = value.map((userJson) => User.fromJson(userJson)).toList();
      for(int i = 0; i < users.length; i++){
        User user = users.elementAt(i);
        _userHash[user.idUser] = user;
      }
    } catch (e){
      return users;
    }
    users.sort((user1, user2) => user1.userName.compareTo(user2.userName));
    return users;
  }

}