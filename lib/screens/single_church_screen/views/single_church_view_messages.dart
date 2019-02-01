import 'package:flutter/material.dart';
import 'package:prayer_app/components/inputs/message_input_field_area.dart';
import 'package:prayer_app/model/church.dart';
import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/utils/church_firebase.dart';

class SingleChurchViewMessages extends StatelessWidget {
  User user;
  Church church;

  SingleChurchViewMessages({@required this.user, @required this.church});

  @override
  Widget build(BuildContext context) {
    return SingleChurchViewMessagesState(user, church);
  }
}

class SingleChurchViewMessagesState extends StatefulWidget {
  User user;
  Church church;

  SingleChurchViewMessagesState(this.user, this.church);

  _SingleChurchViewMessagesState createState() =>
      _SingleChurchViewMessagesState();
}

class _SingleChurchViewMessagesState
    extends State<SingleChurchViewMessagesState> {
  TextEditingController _messageTextController = TextEditingController();
  String _textMessage;

  @override
  void initState() {
    _messageTextController.addListener(_onMessageTextChanged);
    _textMessage = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _buildMessageList(),
        Divider(height: 2.0,),
        Container(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: MessageInputFieldArea(
            controller: _messageTextController,
            onMessageSend: () {
              if (_textMessage != '') {
                ChurchFirebase().sendMessageToChurch(_textMessage,
                    this.widget.user, this.widget.church.idChurch);
              }
            },
          ),
        ),
      ],
    ));
  }

  void _onMessageTextChanged() {
    _textMessage = _messageTextController.text;
  }

  Widget _buildMessageList() {
    return Text('Test');
  }

//  Widget _messageFromSnapshot(DataSnapshot snapshot, Animation<double> animation) {
//    String text = snapshot.value['text'];
//    return Text(text);
//    SizeTransition(
//      sizeFactor: CurvedAnimation(parent: animation, curve: Curves.easeOut),
//      axisAlignment: 0.0,
//      child: Text(text),
//    );
//  }
}
