import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:prayer_app/utils/firebase_storage_utils.dart';

class PrayFirebaseStorage{

  static final PrayFirebaseStorage _prayFirebaseStorage = PrayFirebaseStorage._internal();
  final StorageReference _storage = FirebaseStorageUtils().getInstanceStorageReference();

  factory PrayFirebaseStorage(){
    return _prayFirebaseStorage;
  }
  PrayFirebaseStorage._internal();

  final String _extension = 'jpg';

  Future<dynamic> uploadPrayProfilePicture(int idPray, File file) async {

    final StorageReference ref =
    _storage.child('prays').child('prayprofile$idPray.$_extension');
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
    _storage.child('prays').child('prayprofile$idPray.$_extension');
    return ref.getDownloadURL();
  }

}