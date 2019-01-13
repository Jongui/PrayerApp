import 'package:flutter/material.dart';
import 'package:prayer_app/components/cardviews/church_card_view.dart';
import 'package:prayer_app/model/church.dart';
import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/screens/loading_screen/loading_view.dart';
import 'package:prayer_app/utils/church_http.dart';

class ChurchesListView extends StatelessWidget {
  User user;

  ChurchesListView({@required this.user});

  @override
  Widget build(BuildContext context) {
    return ChurchesListViewState(user);
  }
}

class ChurchesListViewState extends StatefulWidget {
  User user;

  ChurchesListViewState(this.user);

  @override
  _ChurchesListViewState createState() => _ChurchesListViewState(user);
}

class _ChurchesListViewState extends State<ChurchesListViewState> {
  User user;

  _ChurchesListViewState(this.user);
  Widget _view;
  List<Widget> _churchList = [];

  @override
  void initState() {
    _view = LoadingView();
    _handleChurchesLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _view;
  }

  void _handleChurchesLoad() async {
    List<Church> churches = await ChurchHttp().getChurches();
    Church _church = await ChurchHttp().getChurch(user.idUser, user.token);
    setState(() {
      _churchList = [];
      _churchList.add(ChurchCardView(
        church: _church,
        user: user,
      ));
      for (int i = 0; i < churches.length; i++) {
        Church church = churches.elementAt(i);
        if(church.idChurch != _church.idChurch){
          _churchList.add(ChurchCardView(
            church: church,
            user: user,
          ));
        }
      }
      _view = ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(20.0),
        children: _churchList,
      );
    });
  }
}
