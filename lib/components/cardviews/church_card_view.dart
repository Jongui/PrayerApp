import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prayer_app/components/buttons/delete_button.dart';
import 'package:prayer_app/components/dialogs/ok_dialog.dart';
import 'package:prayer_app/components/dialogs/process_dialog.dart';
import 'package:prayer_app/components/views/country_flag_view.dart';
import 'package:prayer_app/localizations.dart';
import 'package:prayer_app/model/church.dart';
import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/screens/single_church_screen/single_church_screen.dart';
import 'package:prayer_app/utils/church_firebase.dart';
import 'package:prayer_app/utils/church_http.dart';
import 'package:prayer_app/utils/firebase_admob_utils.dart';

class ChurchCardView extends StatefulWidget {
  Church church;
  User user;
  String token;
  ValueChanged<Church> onItemDeleted;

  ChurchCardView({@required this.church, @required this.user, @required this.token, @required this.onItemDeleted});

  _ChurchCardViewState createState() => _ChurchCardViewState();
}

class _ChurchCardViewState extends State<ChurchCardView> {
  ImageProvider _profileImageProvider;
  @override
  void initState() {
    _profileImageProvider = AssetImage("assets/church_background.jpg");
    downloadFirebaseChurchProfileImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _disposeScreenBanner();
          Navigator.of(context)
              .push(new MaterialPageRoute(
                  builder: (context) => SingleChurchScreen(
                        church: this.widget.church,
                        user: this.widget.user,
                      )))
              .whenComplete(onReload);
        },
        child: Card(
            color: Colors.grey[100],
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: buildCardComponents(context),
        )));
  }

  List<Widget> buildCardComponents(BuildContext context) {
    List<Widget> ret = [];
    ret.add(Container(
      height: 192.0,
      decoration: new BoxDecoration(
          image:
              DecorationImage(image: _profileImageProvider, fit: BoxFit.cover)),
    ));
    ret.add(Container(
      child: ListTile(
        title: Text(
          this.widget.church.name,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        subtitle: CountyFlagView(
          country: this.widget.church.country,
          width: 36.0,
          height: 36.0,
        ),
      ),
    ));
    if(this.widget.user.idUser == this.widget.church.createdBy){
      ret.add(Container(
        padding: EdgeInsets.only(right: 10.0, bottom: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            DeleteButton(
              height: 28.0,
              width: 100.0,
              onPressed: _onDeleteChurchPressed,
            ),
          ],
        )

      ));

    }
    return ret;
  }

  void _onDeleteChurchPressed() async{
    int _action = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          contentPadding: EdgeInsets.all(10.0),
          title: Text(AppLocalizations().possibleActions),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 0);
              },
              child: Text(AppLocalizations().delete),
            )
          ],
        );
      },
    );

    showDialog(
        context: context,
        builder: (_) => ProcessDialog(
          text: AppLocalizations.of(context).deletingChurch,
        ));

    switch (_action) {

      case 0:
        int response = await ChurchHttp().deleteChurch(this.widget.church.idChurch, this.widget.token);
        Navigator.pop(context);
        if(response == 204){
          Navigator.pop(context);
          this.widget.onItemDeleted(this.widget.church);
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => OkDialog(
              text: AppLocalizations.of(context).churchDeleted,
              backgroundColor: Colors.green,
              icon: Icons.check,
            )
          );
        } else {
          showDialog<String>(
              context: context,
              builder: (BuildContext context) => OkDialog(
                text: AppLocalizations.of(context).churchNotDeleted,
                backgroundColor: Colors.red,
                icon: Icons.error,
              )
          );
        }
        break;
      default:
        Navigator.pop(context);
        break;
    }

  }

  void downloadFirebaseChurchProfileImage() async {
    StorageReference ref = await ChurchFirebase()
        .downloadChurchProfilePicture(this.widget.church.idChurch);
    if (ref == null) {
      return;
    }
    try {
      String _imageUrl = await ref.getDownloadURL();
      setState(() {
        if (_imageUrl != null) {
          _profileImageProvider = NetworkImage(_imageUrl);
        }
      });
    } catch (e) {}
  }

  onReload() async {
    FirebaseAdmobUtils().initScreenBanner();
    await FirebaseAdmobUtils().loadScreenBanner();
    downloadFirebaseChurchProfileImage();
  }

  void _disposeScreenBanner() {
    FirebaseAdmobUtils().disposeScreenBanner();
  }
}
