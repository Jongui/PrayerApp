import 'package:flutter/material.dart';
import 'package:prayer_app/components/cardviews/church_card_view.dart';
import 'package:prayer_app/model/church.dart';
import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/screens/loading_screen/loading_view.dart';
import 'package:prayer_app/utils/church_http.dart';

class ChurchesListView extends StatefulWidget {
  User user;

  ChurchesListView({@required this.user});

  @override
  _ChurchesListViewState createState() => _ChurchesListViewState(user);
}

class _ChurchesListViewState extends State<ChurchesListView> {
  User user;

  _ChurchesListViewState(this.user);
  Widget _view;
  List<ChurchCardView> _churchList = [];
  bool _reload = false;

  @override
  void initState() {
    _view = LoadingView();
    _handleChurchesLoad();
    super.initState();
  }

  @override
  void deactivate() {
    _reload = true;
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    if (_reload) _handleChurchesLoad();
    return _view;
  }

  void _handleChurchesLoad() async {
    List<Church> churches = await ChurchHttp().getChurches();
    if (churches.length == 0) {
      setState(() {
        _reload = false;
        _view = ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(20.0),
          children: _churchList,
        );
      });
      return;
    }
    Church _church = await ChurchHttp().getChurch(user.church, user.token);
    setState(() {
      _reload = false;
      _churchList = [];
      if (_church.idChurch != null) {
        _churchList.add(ChurchCardView(
          church: _church,
          user: user,
          token: user.token,
          onItemDeleted: (church) {
            _itemDeleted(church);
          },
        ));
      }
      for (int i = 0; i < churches.length; i++) {
        Church church = churches.elementAt(i);
        if (church.idChurch != _church.idChurch) {
          _churchList.add(ChurchCardView(
            church: church,
            user: user,
            token: user.token,
            onItemDeleted: (church) {
              _itemDeleted(church);
            },
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

  void _itemDeleted(Church church) {
    _churchList.removeWhere((view) => view.church.idChurch == church.idChurch);
    setState(() {
      List<Widget> _newWidgets = [];
      _churchList.forEach((widget) async {
        _newWidgets.add(ChurchCardView(
          church: church,
          user: user,
          token: user.token,
          onItemDeleted: (church) {
            _itemDeleted(church);
          },
        ));
      });
      _view = ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(20.0),
        children: _newWidgets,
      );
    });
  }
}
