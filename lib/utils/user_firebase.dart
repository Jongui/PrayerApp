import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:prayer_app/utils/firebase_utils.dart';

class UserFirebase{
  static final UserFirebase _userFirebase = UserFirebase._internal();

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;


  factory UserFirebase(){
    return _userFirebase;
  }

  UserFirebase._internal();

  final StorageReference _storage = FirebaseUtils().getInstanceStorageReference();

  Future<dynamic> uploadUserProfilePicture(int idUser, File file, String description) async {
    List<String> _files = file.path.split('.');
    String _extension = _files[_files.length - 1];
    final StorageReference ref =
    _storage.child('users').child(idUser.toString()).child('profile$idUser.$_extension');
    StorageUploadTask task = ref.putFile(
      file,
      StorageMetadata(
        contentLanguage: 'en',
        customMetadata: <String, String>{'avatarUrl': 'upload$idUser',
          'description': '$description'},
      ),
    );
    StorageTaskSnapshot snapshot = await task.onComplete;
    return snapshot.ref.getDownloadURL();
  }

  Future<FirebaseUser> performFirebaseSignIn() async {
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