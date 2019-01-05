import 'package:flutter/material.dart';
import 'package:prayer_app/model/pray.dart';
import 'package:prayer_app/screens/loading_screen/loading_view.dart';

class PrayAlbumCardView extends StatelessWidget{

  Pray pray;
  String token;

  PrayAlbumCardView({@required this.pray, @required this.token});

  @override
  Widget build(BuildContext context) {
    return PrayAlbumCardViewState(pray, token);
  }



}

class PrayAlbumCardViewState extends StatefulWidget {
  Pray pray;
  String token;
  PrayAlbumCardViewState(this.pray, this.token);

  _PrayAlbumCardViewState createState() => _PrayAlbumCardViewState();
}

class _PrayAlbumCardViewState extends State<PrayAlbumCardViewState>{

  Widget _view;

  @override
  void initState() {
    _view = LoadingView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _view;
  }

}