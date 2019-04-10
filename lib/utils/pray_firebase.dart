import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/utils/firebase_utils.dart';
import 'package:firebase_database/firebase_database.dart';

class PrayFirebase {
  static final PrayFirebase _prayFirebase = PrayFirebase._internal();
  final StorageReference _storage =
      FirebaseUtils().getInstanceStorageReference();
  final DatabaseReference _database =
      FirebaseUtils().getInstanceDatabaseReference();

  factory PrayFirebase() {
    return _prayFirebase;
  }
  PrayFirebase._internal();

  final String _extension = 'jpg';

  Future<dynamic> uploadPrayProfilePicture(
      int idPray, File file, String description) async {
    final StorageReference ref = _storage
        .child('prays')
        .child('$idPray')
        .child('prayprofile$idPray.$_extension');
    StorageUploadTask task = ref.putFile(
      file,
      StorageMetadata(
        contentLanguage: 'en',
        customMetadata: <String, String>{
          'prayprofile': 'upload$idPray',
          'description': '$description'
        },
      ),
    );
    StorageTaskSnapshot snapshot = await task.onComplete;
    return snapshot.ref.getDownloadURL();
  }

  Future<StorageReference> downloadPrayProfilePicture(int idPray) async {
    final StorageReference ref = _storage
        .child('prays')
        .child('$idPray')
        .child('prayprofile$idPray.$_extension');
    return ref;
  }

  Future<StorageReference> downloadPrayAlbumPicture(
      int idPray, String fileName) async {
    return _storage
        .child('prays')
        .child('$idPray')
        .child('album')
        .child(fileName);
  }

  Future<Map<String, String>> uploadPrayAlbumPicture(
      int idPray, File file, String description) async {
    Map<String, String> _ret = Map();
    if (description == null || description == '')
      description = 'No description';
    String _fileName = _timestamp() + _extension;

    _ret['fileName'] = _fileName;

    final StorageReference storageRef = _storage
        .child('prays')
        .child('$idPray')
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
        _database.child('prays').child('$idPray').child('album');
    await databaseReference.child(_fileName).set({'fileAddress': downloadUrl});
    _ret['downloadUrl'] = downloadUrl;

    return _ret;
  }

  String _timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  Future<DatabaseReference> downloadPrayAlbum(int idPray) async {
    final DatabaseReference databaseReference =
        _database.child('prays').child('$idPray').child('album');
    return databaseReference;
  }

  deletePrayPictureAlbum(int idPray, String fileName) async {
    try {
      final StorageReference storageRef = _storage
          .child('prays')
          .child('$idPray')
          .child('album')
          .child('$fileName');

      await storageRef.delete();
    } catch (e) {
      print(e.toString());
    }
    try {
      final DatabaseReference databaseReference = _database
          .child('prays')
          .child('$idPray')
          .child('album')
          .child('$fileName');
      await databaseReference.remove();
    } catch (e) {
      print(e.toString());
    }
  }

  StreamSubscription<Event> subscribeToPrayMessage(int idPray, onData) {
    DatabaseReference _messageReference =
        _database.child('prays').child('$idPray').child('messages');
    return _messageReference.onChildAdded.listen(onData);
  }

  void sendMessageToChurch(String text, User user, int idPray) {
    DatabaseReference _firebaseMsgRef =
        _database.child('prays').child('$idPray').child('messages');
    _firebaseMsgRef.push().set({
      'senderId': user.idUser,
      'senderName': user.userName,
      'text': text,
      'timestamp': DateTime.now().millisecondsSinceEpoch
    });
  }
}
