import 'package:flutter/material.dart';
import 'package:prayer_app/components/buttons/float_add_button.dart';
import 'package:prayer_app/localizations.dart';
import 'package:prayer_app/model/church.dart';
import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/screens/add_church_screen/add_church_screen.dart';
import 'package:prayer_app/screens/churches_screen/views/church_view.dart';

class ChurchesScreen extends StatelessWidget {

  Church church;
  User user;

  ChurchesScreen({@required this.church, @required this.user});

  @override
  Widget build(BuildContext context) {
    return ChurchesScreenState(church, user);
  }

}

class ChurchesScreenState extends StatefulWidget {

  ChurchesScreenState(this.church, this.user, {Key key}) : super(key: key);
  Church church;
  User user;

  @override
  _ChurchesScreenState createState() => new _ChurchesScreenState(church, user);

}

class _ChurchesScreenState extends State<ChurchesScreenState>{

  Church church;
  User user;

  _ChurchesScreenState(this.church, this.user);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).title),
      ),
      body: ChurchView(church, user),
      floatingActionButton: FloatAddButton(
        onPressed:  () {
          Navigator.of(context).push(
              new MaterialPageRoute(
                  builder: (context) => AddChurchScreen(user: user,)
              ));
        },
      ),
    );
  }
}