import 'package:flutter/material.dart';
import 'package:prayer_app/components/cardviews/user_card_view.dart';
import 'package:prayer_app/localizations.dart';
import 'package:prayer_app/model/pray.dart';
import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/screens/add_user_to_pray_screen/directory/search_user_delegate.dart';
import 'package:prayer_app/utils/user_pray_http.dart';

class AddUserToPrayScreen extends StatelessWidget {

  List<User> users;
  Pray pray;
  String token;

  AddUserToPrayScreen(
      {@required this.users, @required this.pray, @required this.token});

  @override
  Widget build(BuildContext context) {
    return AddUserToPrayScreenState(users, pray, token);
  }

}

class AddUserToPrayScreenState extends StatefulWidget{
  List<User> users;
  Pray pray;
  String token;
  AddUserToPrayScreenState(this.users, this.pray, this.token);

  _AddUserToPrayScreenState createState() => _AddUserToPrayScreenState(users, pray, token);

}

class _AddUserToPrayScreenState extends State<AddUserToPrayScreenState>{
  List<User> users;
  Pray pray;
  String token;
  SearchUserDelegate _delegate;
  _AddUserToPrayScreenState(this.users, this.pray, this.token);

  @override
  void initState() {
    _delegate = SearchUserDelegate(users: users);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(AppLocalizations.of(context).editUser),
        actions: <Widget>[
          IconButton(
            tooltip: 'Search',
            icon: const Icon(Icons.search),
            onPressed: () async {
              await showSearch<String>(
                context: context,
                delegate: _delegate,
              );
              User _user = _delegate.selectedUser;
              if(_user != null){
                await UserPrayHttp().postUserPray(_user, pray, DateTime.now(), pray.endDate, token);
                Navigator.pop(context, true);
              }
            },
          ),
        ],
      ),
      body: Scrollbar(
          child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, idx) => ListTile(
                title: UserCardView(user: users[idx],),
                onTap: () async {
                  User _user = users[idx];
                  await UserPrayHttp().postUserPray(_user, pray, DateTime.now(), pray.endDate, token);
                  Navigator.pop(context, true);
                },
              )
          )
      ),
    );
  }


}