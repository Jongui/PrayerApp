import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:prayer_app/components/inputs/message_input_field_area.dart';
import 'package:prayer_app/components/views/message_view.dart';
import 'package:prayer_app/model/message.dart';
import 'package:prayer_app/model/pray.dart';
import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/utils/pray_firebase.dart';

class SinglePrayViewMessages extends StatefulWidget{

  final User user;
  final Pray pray;

  SinglePrayViewMessages({@required this.user, @required this.pray});

  _SinglePrayViewMessagesState createState() => _SinglePrayViewMessagesState();
}

class _SinglePrayViewMessagesState extends State<SinglePrayViewMessages>{

  TextEditingController _messageTextController = TextEditingController();
  String _textMessage;
  StreamSubscription<Event> _onMessageAddedSubscription;
  List<Message> _messages;

  @override
  void initState() {
    _messages = List();
    _messageTextController.addListener(_onMessageTextChanged);
    _textMessage = '';
    _onMessageAddedSubscription = PrayFirebase()
        .subscribeToPrayMessage(this.widget.pray.idPray, _onMessageAdded);
    super.initState();
  }

  @override
  void dispose() {
    _onMessageAddedSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _buildMessageList(),
                Divider(
                  height: 2.0,
                ),
                Container(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: MessageInputFieldArea(
                    controller: _messageTextController,
                    onMessageSend: () {
                      if (_textMessage != '') {
                        PrayFirebase().sendMessageToChurch(_textMessage,
                            this.widget.user, this.widget.pray.idPray);
                        _textMessage = _messageTextController.text = '';
                      }
                    },
                  ),
                ),
              ],
            )));
  }

  void _onMessageTextChanged() {
    _textMessage = _messageTextController.text;
  }

  void _onMessageAdded(Event event) async {
    setState(() {
      Message _message = Message.fromSnapshot(event.snapshot);
      _messages.add(_message);
      _messages.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    });
  }

  Widget _buildMessageList() {
    return Container(
        height: 500.0,
        child: ListView.builder(
            reverse: true,
            itemCount: _messages.length,
            itemBuilder: (context, position) {
              Message _message = _messages[position];
              return MessageView(
                message: _message,
                token: this.widget.user.token,
              );
            }));
  }

}