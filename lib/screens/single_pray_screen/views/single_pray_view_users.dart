import 'package:flutter/material.dart';
import 'package:prayer_app/components/views/user_pray_view.dart';
import 'package:prayer_app/model/pray.dart';
import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/model/user_pray.dart';
import 'package:prayer_app/utils/user_http.dart';
import 'package:prayer_app/utils/user_pray_http.dart';

class SinglePrayViewUsers extends StatelessWidget {
  Pray pray;
  String token;

  SinglePrayViewUsers({@required this.pray, @required this.token});

  @override
  Widget build(BuildContext context) {
    return SinglePrayViewUsersState(pray, token);
  }
}

class SinglePrayViewUsersState extends StatefulWidget {
  Pray pray;
  String token;
  SinglePrayViewUsersState(this.pray, this.token);

  _SinglePrayViewUsersState createState() =>
      _SinglePrayViewUsersState(pray, token);
}

class _SinglePrayViewUsersState extends State<SinglePrayViewUsersState> {
  Pray pray;
  String token;
  bool _reload = false;
  List<Widget> _usersList = [];

  _SinglePrayViewUsersState(this.pray, this.token);

  @override
  void deactivate() {
    _reload = true;
  }

  @override
  void initState() {
    _handleLoadPraysUsers();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_reload) {
      _handleLoadPraysUsers();
      _reload = false;
    }
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(20.0),
      children: _usersList,
    );
  }

  _handleLoadPraysUsers() async {
    List<UserPray> list =
        await UserPrayHttp().getUserPrayByPray(pray.idPray, token);
    List<User> userList = [];
    for (int i = 0; i < list.length; i++) {
      UserPray userPray = list.elementAt(i);
      User user = UserHttp().getOfflineUser(userPray.idUser);
      if (user == null) user = await UserHttp().getUser(userPray.idUser, token);
      userList.add(user);
    }
    if (mounted) {
      setState(() {
        _usersList = [];
        for (int i = 0; i < userList.length; i++) {
          User user = userList.elementAt(i);
          int rate = 0;
          for (int j = 0; j < list.length; j++) {
            UserPray userPray = list.elementAt(j);
            if (userPray.idUser == user.idUser) {
              rate = userPray.rate;
              break;
            }
          }
          _usersList.add(UserPrayView(
            user: user,
            token: token,
            rate: rate,
          ));
        }
      });
    }
  }
}
