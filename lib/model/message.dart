import 'package:firebase_database/firebase_database.dart';

class Message{
  String avatarUrl;
  int senderId;
  String senderName;
  String text;
  DateTime timestamp;


  Message({this.avatarUrl, this.senderId, this.senderName, this.text, this.timestamp});

  factory Message.fromSnapshot(DataSnapshot snapshot){
    return Message(
      senderId: snapshot.value['senderId'],
      senderName: snapshot.value['senderName'],
      text: snapshot.value['text'],
      timestamp: DateTime.fromMillisecondsSinceEpoch(snapshot.value['timestamp']),
    );
  }


}
