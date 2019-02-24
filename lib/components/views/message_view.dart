import 'package:flutter/material.dart';
import 'package:prayer_app/model/message.dart';
import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/utils/user_http.dart';

class MessageView extends StatefulWidget {
  Message message;
  String token;

  MessageView({@required this.message, @required this.token});

  _MessageViewState createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  User _user;

  String _avatar;

  @override
  void initState() {
    _handleLoadUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _checkAvatarChanged();
    return Container(
      margin: EdgeInsets.only(bottom: 10.0, top: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              radius: 20.0,
              backgroundColor: Colors.grey,
              backgroundImage:
                  _avatar != null ? new NetworkImage(_avatar) : null,
            ),
            Flexible(
              fit: FlexFit.loose,
              child: Container(
                margin: EdgeInsets.only(top: 10.0),
                child: Text(
                this.widget.message.text,
                softWrap: true,
                overflow: TextOverflow.clip,
              )
              ),
            ),
          ],
        ));
  }

  void _handleLoadUser() async {
    _user = await UserHttp()
        .getUser(this.widget.message.senderId, this.widget.token);
    setState(() {
      _avatar = _user.avatarUrl;
    });
  }

  _checkAvatarChanged() {
    if(_user == null){
      return;
    }
    if(_user.idUser != this.widget.message.senderId){
      _handleLoadUser();
    }
  }

}
