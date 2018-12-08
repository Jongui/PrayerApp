import 'package:flutter/material.dart';
import 'package:prayer_app/components/buttons/float_add_button.dart';
import 'package:prayer_app/localizations.dart';
import 'package:prayer_app/model/church.dart';
import 'package:prayer_app/screens/add_church_screen/add_church_screen.dart';
import 'package:prayer_app/screens/churches_screen/views/church_view.dart';

class ChurchesScreen extends StatelessWidget {

  Church church;
  String token;

  ChurchesScreen(this.church, this.token);

  @override
  Widget build(BuildContext context) {
    return ChurchesScreenState(church, token);
  }

}

class ChurchesScreenState extends StatefulWidget {

  ChurchesScreenState(this.church, this.token, {Key key}) : super(key: key);
  Church church;
  String token;

  @override
  _ChurchesScreenState createState() => new _ChurchesScreenState(church, token);

}

class _ChurchesScreenState extends State<ChurchesScreenState>{

  Church church;
  String token;

  _ChurchesScreenState(this.church, this.token);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).title),
      ),
      body: ChurchView(church, token),
      floatingActionButton: FloatAddButton(
        onPressed:  () {
          Navigator.of(context).push(
              new MaterialPageRoute(
                  builder: (context) => AddChurchScreen(token: token,)
              ));
        },
      ),
    );
  }
}