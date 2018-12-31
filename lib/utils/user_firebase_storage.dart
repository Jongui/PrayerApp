import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:prayer_app/utils/firebase_storage_utils.dart';

class UserFirebaseStorage{
  static final UserFirebaseStorage _userFirebaseStorage = UserFirebaseStorage._internal();

  factory UserFirebaseStorage(){
    return _userFirebaseStorage;
  }

  UserFirebaseStorage._internal();

  final StorageReference _storage = FirebaseStorageUtils().getInstanceStorageReference();

  Future<dynamic> uploadUserProfilePicture(int idUser, File file) async {
    List<String> _files = file.path.split('.');
    String _extension = _files[_files.length - 1];
    final StorageReference ref =
    _storage.child('users').child(idUser.toString()).child('profile$idUser.$_extension');
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