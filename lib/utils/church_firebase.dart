import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:prayer_app/utils/firebase_utils.dart';

class ChurchFirebase{
  static final ChurchFirebase _churchFirebase = ChurchFirebase._internal();
  final StorageReference _storage = FirebaseUtils().getInstanceStorageReference();
  //final DatabaseReference _database = FirebaseUtils().getInstanceDatabaseReference();

  factory ChurchFirebase(){
    return _churchFirebase;
  }

  ChurchFirebase._internal();

  final String _extension = 'jpg';

  Future<dynamic> uploadChurchProfilePicture(int idChurch, File file, String description) async {
    final StorageReference ref =
    _storage.child('churchs').child('$idChurch').child('churchprofile$idChurch.$_extension');
    StorageUploadTask task = ref.putFile(
      file,
      StorageMetadata(
        contentLanguage: 'en',
        customMetadata: <String, String>{'churchprofile': 'upload$idChurch',
          'description':'$description'},
      ),
    );
    StorageTaskSnapshot snapshot = await task.onComplete;
    return snapshot.ref.getDownloadURL();
  }

  Future<StorageReference> downloadPrayProfilePicture(int idChurch) async {
    final StorageReference ref =
    _storage.child('churchs').child('$idChurch').child('churchprofile$idChurch.$_extension');
    return ref;
  }

}