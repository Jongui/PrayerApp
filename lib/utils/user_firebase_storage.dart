import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class UserFirebaseStorage{
  static final UserFirebaseStorage _userFirebaseStorage = UserFirebaseStorage._internal();

  factory UserFirebaseStorage(){
    return _userFirebaseStorage;
  }

  UserFirebaseStorage._internal();

  final FirebaseStorage _storage = FirebaseStorage(storageBucket: "gs://prayingapp-76292.appspot.com");

  Future<dynamic> uploadUserProfilePicture(int idUser, File file) async {
    List<String> _files = file.path.split('.');
    String _extension = _files[_files.length - 1];
    final StorageReference ref =
    _storage.ref().child(idUser.toString()).child('profile$idUser.$_extension');
    StorageUploadTask task = ref.putFile(
      file,
      StorageMetadata(
        contentLanguage: 'en',
        customMetadata: <String, String>{'avatarUrl': 'upload$idUser'},
      ),
    );
    StorageTaskSnapshot snapshot = await task.onComplete;
    return snapshot.ref.getDownloadURL();
  }
}