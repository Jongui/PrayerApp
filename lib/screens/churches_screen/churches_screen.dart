import 'package:flutter/material.dart';
import 'package:prayer_app/components/buttons/float_add_button.dart';
import 'package:prayer_app/localizations.dart';
import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/screens/add_church_screen/add_church_screen.dart';
import 'package:prayer_app/screens/churches_screen/views/churches_view.dart';

class ChurchesScreen extends StatelessWidget {
  User user;

  ChurchesScreen({@required this.user});

  @override
  Widget build(BuildContext context) {
    return ChurchesScreenState(user);
  }
}

class ChurchesScreenState extends StatefulWidget {
  ChurchesScreenState(this.user, {Key key}) : super(key: key);
  User user;

  @override
  _ChurchesScreenState createState() => new _ChurchesScreenState();
}

class _ChurchesScreenState extends State<ChurchesScreenState> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).title),
      ),
      body: ChurchesView(user: this.widget.user),
      floatingActionButton: FloatAddButton(
        bottomMargin: 80.0,
        onPressed: () {
          Navigator.of(context).push(new MaterialPageRoute(
              builder: (context) => AddChurchScreen(
                    user: this.widget.user,
                  ))).whenComplete(onReload);
        },
      ),
    );
  }
  onReload() async {
    setState(() {

    });
  }

}
