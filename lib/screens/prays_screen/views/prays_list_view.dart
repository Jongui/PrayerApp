import 'package:flutter/material.dart';
import 'package:prayer_app/components/cardviews/pray_card_view.dart';
import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/model/user_pray.dart';
import 'package:prayer_app/utils/user_pray_http.dart';

class PrayListView extends StatefulWidget {
  User user;
  String token;

  PrayListView({@required this.user, @required this.token});

  @override
  _PrayListViewState createState() => new _PrayListViewState();
}

class _PrayListViewState extends State<PrayListView> {
  List<Widget> _views = [];
  bool _reload = false;

  _PrayListViewState();

  @override
  void deactivate() {
    _reload = true;
    super.deactivate();
  }

  @override
  void initState() {
    _handleLoadPray();
  }

  @override
  Widget build(BuildContext context) {
    if (_reload) _handleLoadPray();
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

  _handleLoadPray() async {
    List<UserPray> userPrays =
        await UserPrayHttp().getUserPrayByUser(this.widget.user.idUser, this.widget.user.token);
    setState(() {
      _reload = false;
      _views = [];
      for (int j = 0; j < userPrays.length; j++) {
        UserPray userPray = userPrays.elementAt(j);
        _views.add(PrayCardView(
          userPray: userPray,
          user: this.widget.user,
          token: this.widget.token,
        ));
      }
    });
  }
}
