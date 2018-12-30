import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class PrayFirebaseStorage{

  static final PrayFirebaseStorage _prayFirebaseStorage = PrayFirebaseStorage._internal();
  final FirebaseStorage _storage = FirebaseStorage(storageBucket: "gs://prayingapp-76292.appspot.com");

  factory PrayFirebaseStorage(){
    return _prayFirebaseStorage;
  }
  PrayFirebaseStorage._internal();

  final String _extension = 'jpg';

  Future<dynamic> uploadPrayProfilePicture(int idPray, File file) async {

    final StorageReference ref =
    _storage.ref().child('prays').child('prayprofile$idPray.$_extension');
    StorageUploadTask task = ref.putFile(
      file,
      StorageMetadata(
        contentLanguage: 'en',
        customMetadata: <String, String>{'prayprofile': 'upload$idPray'},
      ),
    );
    StorageTaskSnapshot snapshot = await task.onComplete;
    return snapshot.ref.getDownloadURL();
  }

  Future<dynamic> downloadPrayProfilePicture(int idPray) async {
    final StorageReference ref =
    _storage.ref().child('prays').child('prayprofile$idPray.$_extension');
    return ref.getDownloadURL();
  }

}