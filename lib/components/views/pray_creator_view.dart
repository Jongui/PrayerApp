import 'package:flutter/material.dart';
import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/utils/user_http.dart';

class PrayCreatorView extends StatelessWidget {

  int idCreator;

  PrayCreatorView({@required this.idCreator});

  @override
  Widget build(BuildContext context) {
    return PrayCreatorViewState(idCreator);
  }

}

class PrayCreatorViewState extends StatefulWidget{

  int idCreator;

  PrayCreatorViewState(this.idCreator);

  _PrayCreatorViewState createState() => _PrayCreatorViewState(idCreator);

}

class _PrayCreatorViewState extends State<PrayCreatorViewState>{

  int idCreator;
  User _creator;
  String _subtext;

  _PrayCreatorViewState(this.idCreator);

  @override
  void initState() {
    _creator = User();
    _handleCreatorLoading(idCreator);
    _subtext = "Loading";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      margin: EdgeInsets.only(left: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            radius: 20.0,
            backgroundColor: Colors.grey,
            backgroundImage: _creator.avatarUrl != null ? new NetworkImage(
                _creator.avatarUrl) : null,
          ),
          Container(
            width: 120.0,
            margin: EdgeInsets.only(left: 10.0),
            child: Text(_subtext),
          )
        ],
      )
    );
  }

  void _handleCreatorLoading(int idCreator) async{
    User user = await UserHttp().getUser(idCreator);
    setState(() {
      _creator = user;
      _subtext = "Created by " + _creator.userName;
    });
  }

}