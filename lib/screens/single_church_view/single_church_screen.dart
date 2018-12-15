import 'package:flutter/material.dart';
import 'package:prayer_app/components/buttons/float_edit_button.dart';
import 'package:prayer_app/localizations.dart';
import 'package:prayer_app/model/church.dart';
import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/screens/edit_church_screen/edit_church_screen.dart';
import 'package:prayer_app/screens/single_church_view/views/single_church_view.dart';

class SingleChurchScreen extends StatelessWidget{

  Church church;
  User user;

  SingleChurchScreen({@required this.church, @required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text(AppLocalizations.of(context).viewChurch),
    ),
    body: SingleChurchView(church: church,
      user: user,
    ),
      floatingActionButton: user.idUser == church.createdBy ? FloatEditButton(onAddPressed: ()  {

      }, onEditPressed: () {
        Navigator.of(context).push(
            new MaterialPageRoute(
                builder: (context) => EditChurchScreen(church: church,
                  user: user,)
            ));
      }) : null,
    );
  }

}