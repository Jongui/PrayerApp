import 'package:firebase_storage/firebase_storage.dart';

class FirebaseUtils{
  static final FirebaseUtils _firebaseUtils = FirebaseUtils._internal();
  final FirebaseStorage _storage = FirebaseStorage(storageBucket: "gs://prayingapp-76292.appspot.com");

  factory FirebaseUtils(){
    return _firebaseUtils;
  }
  FirebaseUtils._internal();

  StorageReference getInstanceStorageReference(){
    return _storage.ref().child('dev');
  }

}