import 'package:flutter/material.dart';
import 'package:prayer_app/localizations.dart';
import 'package:prayer_app/model/church.dart';
import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/utils/church_http.dart';

class UserPrayView extends StatelessWidget{

  User user;
  String token;
  int rate;

  UserPrayView({@required this.user, @required this.token, @required this.rate});

  @override
  Widget build(BuildContext context) {
    return UserPrayViewState(user, token, rate);
  }

}

class UserPrayViewState extends StatefulWidget{
  User user;
  String token;
  int rate;

  UserPrayViewState(this.user, this.token, this.rate);

  _UserPrayViewState createState() => _UserPrayViewState(user, token, rate);

}

class _UserPrayViewState extends State<UserPrayViewState>{

  User user;
  String token;
  int rate;

  String _churchName;
  _UserPrayViewState(this.user, this.token, this.rate);

  @override
  void initState() {
    _churchName = "Loading";
    _handleChurchLoad();
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
              backgroundImage: user.avatarUrl != null ? new NetworkImage(
                  user.avatarUrl) : null,
            ),
            Container(
              width: 305.0,
              margin: EdgeInsets.only(left: 10.0),
              child: ListTile(
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(user.userName,
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    )
                  ],
                ),
                subtitle: Container(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(_churchName,
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      Text(AppLocalizations.of(context).ratedByUser(rate.toString()),
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),)
                    ],
                  )
                )
              ),
            )
          ],
        )
    );
  }

  _handleChurchLoad() async{
    Church church = ChurchHttp().getChurchOffline(user.church);
    if(church == null)
      church = await ChurchHttp().getChurch(user.church, token);
    setState(() {
      _churchName = church.name;
    });
  }

}