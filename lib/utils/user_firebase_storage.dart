import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:prayer_app/utils/firebase_utils.dart';

class UserFirebaseStorage{
  static final UserFirebaseStorage _userFirebaseStorage = UserFirebaseStorage._internal();

  factory UserFirebaseStorage(){
    return _userFirebaseStorage;
  }

  UserFirebaseStorage._internal();

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
}