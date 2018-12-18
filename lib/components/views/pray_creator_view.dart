import 'package:flutter/material.dart';
import 'package:prayer_app/localizations.dart';
import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/utils/user_http.dart';

class PrayCreatorView extends StatelessWidget {

  int idCreator;
  String token;

  PrayCreatorView({@required this.idCreator, @required this.token});

  @override
  Widget build(BuildContext context) {
    return PrayCreatorViewState(idCreator, token);
  }

}

class PrayCreatorViewState extends StatefulWidget{

  int idCreator;
  String token;

  PrayCreatorViewState(this.idCreator, this.token);

  _PrayCreatorViewState createState() => _PrayCreatorViewState(idCreator, token);

}

class _PrayCreatorViewState extends State<PrayCreatorViewState>{

  int idCreator;
  User _creator;
  String _subtext;
  String token;

  _PrayCreatorViewState(this.idCreator, this.token);

  @override
  void initState() {
    _creator = User();
    _handleCreatorLoading(idCreator);
    _subtext = "Loading";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(_creator.userName != null) {
      _subtext = AppLocalizations.of(context).createdBy(_creator.userName);
    }
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
    User user = await UserHttp().getUser(idCreator, token);
    setState(() {
      _creator = user;
    });
  }

}