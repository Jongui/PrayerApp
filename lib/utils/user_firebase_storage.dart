import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class UserFirebaseStorage{
  static final UserFirebaseStorage _userFirebaseStorage = UserFirebaseStorage._internal();

  factory UserFirebaseStorage(){
    return _userFirebaseStorage;
  }

  UserFirebaseStorage._internal();

  final FirebaseStorage _storage = FirebaseStorage(storageBucket: "gs://prayingapp-76292.appspot.com");

  Future<Null> uploadFile(String userEmail) async {
    final String uuid = Uuid().v1();
    final Directory systemTempDir = Directory.systemTemp;
    final File file = await File('${systemTempDir.path}/foo$uuid.txt').create();
    await file.writeAsString("Hello World");
    assert(await file.readAsString() == "Hello World");
    final StorageReference ref =
    _storage.ref().child(userEmail).child('foo$uuid.txt');
    ref.putFile(
      file,
      StorageMetadata(
        contentLanguage: 'en',
        customMetadata: <String, String>{'activity': 'test'},
      ),
    );
  }
}