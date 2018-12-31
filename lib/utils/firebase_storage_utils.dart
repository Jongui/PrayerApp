import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageUtils{
  static final FirebaseStorageUtils _firebaseStorageUtils = FirebaseStorageUtils._internal();
  final FirebaseStorage _storage = FirebaseStorage(storageBucket: "gs://prayingapp-76292.appspot.com");

  factory FirebaseStorageUtils(){
    return _firebaseStorageUtils;
  }
  FirebaseStorageUtils._internal();

  StorageReference getInstanceStorageReference(){
    return _storage.ref().child('dev');
  }

}