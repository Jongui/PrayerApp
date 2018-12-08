import 'package:flutter/material.dart';
import 'package:prayer_app/components/cardviews/pray_card_view.dart';
import 'package:prayer_app/model/pray.dart';
import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/model/user_pray.dart';
import 'package:prayer_app/utils/pray_http.dart';
import 'package:prayer_app/utils/user_pray_http.dart';

class PrayListView extends StatelessWidget {

  User user;

  PrayListView({@required this.user});

  @override
  Widget build(BuildContext context) {
    return PrayListViewState(user);
  }

}

class PrayListViewState extends StatefulWidget {

  User user;

  PrayListViewState(this.user);

  @override
  _PrayListViewState createState() => new _PrayListViewState(user);

}

class _PrayListViewState extends State<PrayListViewState>{

  User user;
  List<Widget> _views = [];

  _PrayListViewState(this.user);


  @override
  void initState() {
    _handleLoadPray(user);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(20.0),
      children: _views,
    );
  }

  _handleLoadPray(User user) async {
    List<Pray> prays = await PrayHttp().getPraysByUser(user);
    List<UserPray> userPrays = await UserPrayHttp().getUserPrayByUser(user.idUser, user.token);
    setState(() {
      _views = [];
      for(int i = 0; i < prays.length; i++){
        Pray pray = prays.elementAt(i);
        UserPray userPray = UserPray();
        for(int j = 0; j < userPrays.length; j++){
          UserPray tmp = userPrays.elementAt(j);
          if(tmp.idPray == pray.idPray){
            userPray = tmp;
            break;
          }
        }
        _views.add(PrayCardView(pray: pray,
          userPray: userPray,
          user: user,));
      }
    });
  }

}