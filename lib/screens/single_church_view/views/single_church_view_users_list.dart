import 'package:flutter/material.dart';
import 'package:prayer_app/components/cardviews/user_card_view.dart';
import 'package:prayer_app/model/church.dart';
import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/utils/user_http.dart';

class SingleChurchViewUsersList extends StatelessWidget{

  Church church;
  User user;

  SingleChurchViewUsersList({@required this.church, @required this.user});

  @override
  Widget build(BuildContext context) {
    return SingleChurchViewUsersListState(church, user);
  }

}

class SingleChurchViewUsersListState extends StatefulWidget{

  Church church;
  User user;
  SingleChurchViewUsersListState(this.church, this.user);

  _SingleChurchViewUsersListState createState() => _SingleChurchViewUsersListState(church, user);

}

class _SingleChurchViewUsersListState extends State<SingleChurchViewUsersListState>{

  Church church;
  User user;
  bool _reload = false;
  List<Widget> _views = [];

  _SingleChurchViewUsersListState(this.church, this.user);


  @override
  void deactivate() {
    _reload = true;
  }

  @override
  void initState() {
    _handleChurchesLoad();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(_reload){
      _handleChurchesLoad();
      _reload = false;
    }

    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(20.0),
      children: _views,
    );
  }

  void _handleChurchesLoad() async{
    List<User> users = await UserHttp().getUsersByChurch(church.idChurch, user.token);
    setState(() {
      _reload = false;
      _views = [];
      for(int i = 0; i < users.length; i++){
        User _user = users.elementAt(i);
        _views.add(UserCardView( user: _user));
      }
    });
  }

}