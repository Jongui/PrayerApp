import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:prayer_app/model/user.dart';
import 'package:http/http.dart' as http;

class UserHttp{
  static final UserHttp _userHttp = new UserHttp._internal();

  factory UserHttp(){
    return _userHttp;
  }

  UserHttp._internal();

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User> createUser(FirebaseUser firebaseUser) async {
    User user = User( email: firebaseUser.email,
        userName: firebaseUser.displayName,
        city: "Curitiba",
        country: "Brazil",
        church: 1);
    final response = await http.post('http://192.168.1.9:8080/api/v1/user',
        headers: {
          "Content-Type": "application/json"
        },
        body: json.encode(user),
        encoding: Encoding.getByName("utf-8")
    );
    if(response.statusCode== 201){

    }
  }

  Future<User> fetchUser(FirebaseUser firebaseUser) async {
    final response =
    await http.get('http://192.168.1.9:8080/api/v1/user/email/' + firebaseUser.email
        + '/');
    try {
      var jsonVar = json.decode(response.body);
      var value = jsonVar['value'];
      var userJson = value[0];
      if (response.statusCode == 200 && userJson != null) {
        print(response.body);
        return User.fromJson(userJson);
      }
    } catch (e){
      return null;
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

}