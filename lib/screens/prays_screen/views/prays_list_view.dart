import 'package:flutter/material.dart';
import 'package:prayer_app/components/cardviews/pray_card_view.dart';
import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/model/user_pray.dart';
import 'package:prayer_app/utils/user_pray_http.dart';

class PrayListView extends StatelessWidget {

  User user;
  String token;

  PrayListView({@required this.user, @required this.token});

  @override
  Widget build(BuildContext context) {
    return PrayListViewState(user, token);
  }

}

class PrayListViewState extends StatefulWidget {

  User user;
  String token;

  PrayListViewState(this.user, this.token);

  @override
  _PrayListViewState createState() => new _PrayListViewState(user, token);

}

class _PrayListViewState extends State<PrayListViewState>{

  User user;
  String token;
  List<Widget> _views = [];
  bool _reload = false;

  _PrayListViewState(this.user, this.token);

  @override
  void deactivate() {
    _reload = true;
    super.deactivate();
  }

  @override
  void initState() {
    _handleLoadPray(user);
  }

  @override
  Widget build(BuildContext context) {
    if(_reload)
      _handleLoadPray(user);
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(20.0),
      children: _views,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  _handleLoadPray(User user) async {
    List<UserPray> userPrays = await UserPrayHttp().getUserPrayByUser(user.idUser, user.token);
    setState(() {
      _reload = false;
      _views = [];
        for(int j = 0; j < userPrays.length; j++){
          UserPray userPray = userPrays.elementAt(j);
          _views.add(PrayCardView(  userPray: userPray,
            user: user,
            token: token,));
        }
    });
  }

}