import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:prayer_app/resources/config.dart';

class FirebaseUtils{
  static final FirebaseUtils _firebaseUtils = FirebaseUtils._internal();
  final FirebaseStorage _storage = FirebaseStorage(storageBucket: "gs://prayingapp-76292.appspot.com");
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  factory FirebaseUtils(){
    return _firebaseUtils;
  }
  FirebaseUtils._internal();

  StorageReference getInstanceStorageReference(){
    return _storage.ref().child(firebaseEnv);
  }

  DatabaseReference getInstanceDatabaseReference(){
    return _database.reference().child(firebaseEnv);
  }

}