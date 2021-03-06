import 'dart:async';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/utils/firebase_utils.dart';

class ChurchFirebase {
  static final ChurchFirebase _churchFirebase = ChurchFirebase._internal();
  final StorageReference _storage =
      FirebaseUtils().getInstanceStorageReference();
  final DatabaseReference _database =
      FirebaseUtils().getInstanceDatabaseReference();

  factory ChurchFirebase() {
    return _churchFirebase;
  }

  ChurchFirebase._internal();

  final String _extension = 'jpg';

  Future<dynamic> uploadChurchProfilePicture(
      int idChurch, File file, String description) async {
    final StorageReference ref = _storage
        .child('churchs')
        .child('$idChurch')
        .child('churchprofile$idChurch.$_extension');
    StorageUploadTask task = ref.putFile(
      file,
      StorageMetadata(
        contentLanguage: 'en',
        customMetadata: <String, String>{
          'churchprofile': 'upload$idChurch',
          'description': '$description'
        },
      ),
    );
    StorageTaskSnapshot snapshot = await task.onComplete;
    return snapshot.ref.getDownloadURL();
  }

  Future<StorageReference> downloadChurchProfilePicture(int idChurch) async {
    final StorageReference ref = _storage
        .child('churchs')
        .child('$idChurch')
        .child('churchprofile$idChurch.$_extension');
    return ref;
  }

  Future<StorageReference> downloadChurchAlbumPicture(
      int idChurch, String fileName) async {
    return _storage
        .child('churchs')
        .child('$idChurch')
        .child('album')
        .child(fileName);
  }

  Future<Map<String, String>> uploadChurchAlbumPicture(
      int idChurch, File file, String description) async {
    Map<String, String> _ret = Map();
    if (description == null || description == '')
      description = 'No description';
    String _fileName = _timestamp() + _extension;

    _ret['fileName'] = _fileName;

    final StorageReference storageRef = _storage
        .child('churchs')
        .child('$idChurch')
        .child('album')
        .child(_fileName);
    StorageUploadTask task = storageRef.putFile(
      file,
      StorageMetadata(
        contentLanguage: 'en',
        customMetadata: <String, String>{'description': '$description'},
      ),
    );
    StorageTaskSnapshot snapshot = await task.onComplete;
    var downloadUrl = await snapshot.ref.getDownloadURL();

    final DatabaseReference databaseReference =
        _database.child('churchs').child('$idChurch').child('album');
    await databaseReference.child(_fileName).set({'fileAddress': downloadUrl});
    _ret['downloadUrl'] = downloadUrl;

    return _ret;
  }

  String _timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  Future<DatabaseReference> downloadChurchAlbum(int idChurch) async {
    final DatabaseReference databaseReference =
        _database.child('churchs').child('$idChurch').child('album');
    return databaseReference;
  }

  Future<void> deleteChurchPictureAlbum(
      int idChurch, String fileName) async {
    try{
      final StorageReference storageRef = _storage
          .child('churchs')
          .child('$idChurch')
          .child('album')
          .child('$fileName');

      await storageRef.delete();

    } catch(e){

    }
    try{
      final DatabaseReference databaseReference =
      _database.child('churchs').child('$idChurch').child('album').child('$fileName');
      await databaseReference.remove();
    } catch(e){

    }
  }

  Future<void> sendMessageToChurch(String text, User user, int idChurch) async {
    DatabaseReference _firebaseMsgRef = _database.child('churchs').child('$idChurch')
      .child('messages');
    _firebaseMsgRef.push().set({
      'senderId': user.idUser,
      'senderName': user.userName,
      'text': text,
      'timestamp': DateTime.now().millisecondsSinceEpoch
    });
  }

  DatabaseReference messagesDatabaseReference(int idChurch){
    return _database.child('churchs').child('$idChurch')
        .child('messages');
  }

  StreamSubscription<Event> subscribeToChurchMessage(int idChurch, void onData(Event event)){
    DatabaseReference _messageReference = _database.child('churchs').child('$idChurch').child('messages');
    return _messageReference.onChildAdded.listen(onData);
  }

}
