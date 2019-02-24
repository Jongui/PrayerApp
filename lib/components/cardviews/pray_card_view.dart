import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prayer_app/components/views/pray_creator_view.dart';
import 'package:prayer_app/components/views/pray_rate_view.dart';
import 'package:prayer_app/localizations.dart';
import 'package:prayer_app/model/pray.dart';
import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/model/user_pray.dart';
import 'package:prayer_app/screens/loading_screen/loading_view.dart';
import 'package:prayer_app/screens/single_pray_screen/single_pray_screen.dart';
import 'package:prayer_app/utils/firebase_admob_utils.dart';
import 'package:prayer_app/utils/pray_http.dart';

class PrayCardView extends StatelessWidget {
  User user;
  UserPray userPray;
  String token;

  PrayCardView(
      {@required this.userPray, @required this.user, @required this.token});

  @override
  Widget build(BuildContext context) {
    return PrayCardViewState(userPray, user, token);
  }
}

class PrayCardViewState extends StatefulWidget {
  User user;
  UserPray userPray;
  String token;
  PrayCardViewState(this.userPray, this.user, this.token);

  _PrayCardViewState createState() => _PrayCardViewState(userPray, user, token);
}

class _PrayCardViewState extends State<PrayCardViewState> {
  static final colors = [
    Colors.green,
    Colors.blue,
    Colors.red,
    Colors.yellow,
    Colors.deepPurple
  ];

  User user;
  UserPray userPray;
  String token;

  Pray _pray;
  Widget _view;

  _PrayCardViewState(this.userPray, this.user, this.token);

  @override
  void initState() {
    _view = LoadingView();
    _handlePrayLoad();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _view;
  }

  void _handlePrayLoad() async {
    _pray = await PrayHttp().getPrayById(userPray.idPray, token);
    setState(() {
      _view = _buildListView();
    });
  }

  Widget _buildListView() {
    var formatterTo = new DateFormat('dd-MM-yyyy');
    String _subtitle = AppLocalizations.of(context).prayFromTo(
        formatterTo.format(_pray.beginDate), formatterTo.format(_pray.endDate));

    var rng = new Random();
    int index = rng.nextInt(colors.length);
    var textColor = colors[index];
    return GestureDetector(
      onTap: () {
        _disposeScreenBanner();
        Navigator.of(context)
            .push(new MaterialPageRoute(
                builder: (context) => SinglePrayScreen(
                      pray: _pray,
                      user: user,
                      userPray: userPray,
                    )))
            .whenComplete(() async {
          FirebaseAdmobUtils().initScreenBanner();
          await FirebaseAdmobUtils().loadScreenBanner();
        });
      },
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              child: ListTile(
                leading: Icon(
                  Icons.album,
                  color: textColor,
                  size: 40.0,
                ),
                title: Text(_pray.description),
                subtitle: Text(_subtitle),
              ),
            ),
            Container(
              color: Colors.grey[100],
              child: Row(
                children: <Widget>[
                  ButtonBar(
                    children: <Widget>[
                      PrayCreatorView(idCreator: _pray.idUser, token: token),
                      PrayRateView(userPray: userPray),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _disposeScreenBanner() {
    FirebaseAdmobUtils().disposeScreenBanner();
  }
}
