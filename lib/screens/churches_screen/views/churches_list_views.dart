import 'package:flutter/material.dart';
import 'package:prayer_app/components/cardviews/church_card_view.dart';
import 'package:prayer_app/model/church.dart';
import 'package:prayer_app/utils/church_http.dart';

class ChurchesListView extends StatelessWidget{

  String token;

  ChurchesListView({@required this.token});

  @override
  Widget build(BuildContext context) {
    return ChurchesListViewState(token);
  }

}

class ChurchesListViewState extends StatefulWidget {

  String token;

  ChurchesListViewState(this.token);

  @override
  _ChurchesListViewState createState() => _ChurchesListViewState(token);
}

class _ChurchesListViewState extends State<ChurchesListViewState>{

  String token;

  _ChurchesListViewState(this.token);

  List<Widget> _churchList = [];

  @override
  void initState() {
    _handleChurchesLoad();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(20.0),
      children: _churchList,
    );
  }

  void _handleChurchesLoad() async{
    List<Church> churches = await ChurchHttp().getChurches();
    setState(() {
      _churchList = [];
      for(int i = 0; i < churches.length; i++) {
        Church church = churches.elementAt(i);
        _churchList.add(ChurchCardView(church: church,
          token: token,)
        );
      }
    });
  }

}