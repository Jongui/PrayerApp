import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:prayer_app/components/dialogs/process_dialog.dart';
import 'package:prayer_app/localizations.dart';
import 'package:prayer_app/model/church.dart';
import 'package:prayer_app/model/pray.dart';
import 'package:prayer_app/utils/church_firebase.dart';
import 'package:prayer_app/utils/pray_firebase.dart';

class AlbumPictureCardView extends StatelessWidget {
  String pictureUrl;
  String fileName;
  Pray pray;
  Church church;
  ValueChanged<String> onItemDeleted;

  AlbumPictureCardView(
      {@required this.pictureUrl,
      @required this.fileName,
        @required this.onItemDeleted,
      this.pray,
      this.church}) {
    assert(this.pray != null || this.church != null);
  }

  @override
  Widget build(BuildContext context) {
    return AlbumPictureCardViewState(pictureUrl, fileName, pray, church, onItemDeleted);
  }
}

class AlbumPictureCardViewState extends StatefulWidget {
  String pictureUrl;
  String fileName;
  Pray pray;
  Church church;
  ValueChanged<String> onItemDeleted;

  AlbumPictureCardViewState(
      this.pictureUrl, this.fileName, this.pray, this.church, this.onItemDeleted);

  _AlbumPictureCardViewState createState() => _AlbumPictureCardViewState();
}

class _AlbumPictureCardViewState extends State<AlbumPictureCardViewState> {
  String _description;

  @override
  void dispose() {
    _description = '';
    super.dispose();
  }

  @override
  void initState() {
    _description = '';
    _handleLoadMetadata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _checkPictureChanged();
    return GestureDetector(
        onLongPress: () {
          _longPressAction();
        },
        child: Card(
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Image(
              image: NetworkImage(this.widget.pictureUrl),
              height: 320.0,
            ),
            Text(_description)
          ]),
        ));
  }

  _handleLoadMetadata() async {
    StorageReference ref;
    if (this.widget.pray != null) {
      ref = await PrayFirebase().downloadPrayAlbumPicture(
          this.widget.pray.idPray, this.widget.fileName);
    } else {
      ref = await ChurchFirebase().downloadChurchAlbumPicture(
          this.widget.church.idChurch, this.widget.fileName);
    }
    StorageMetadata metadata = await ref.getMetadata();
    Map customMetadata = metadata.customMetadata;
    setState(() {
      _description = customMetadata['description'];
    });
  }

  _checkPictureChanged() async {
    StorageReference ref;
    if (this.widget.pray != null) {
      ref = await PrayFirebase().downloadPrayAlbumPicture(
          this.widget.pray.idPray, this.widget.fileName);
    } else {
      ref = await ChurchFirebase().downloadChurchAlbumPicture(
          this.widget.church.idChurch, this.widget.fileName);
    }
    StorageMetadata metadata = await ref.getMetadata();
    Map customMetadata = metadata.customMetadata;
    if (customMetadata['description'] != _description) {
      _description = customMetadata['description'];
      setState(() {});
    }
  }

  void _longPressAction() async {
    int _action = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
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
          text: AppLocalizations.of(context).deletingPicture,
        ));

    switch (_action) {

      case 0:
        if (this.widget.church != null) {
          await ChurchFirebase().deleteChurchPictureAlbum(
              this.widget.church.idChurch, this.widget.fileName);
          this.widget.onItemDeleted(this.widget.fileName);
        } else if(this.widget.pray != null){
          await PrayFirebase().deletePrayPictureAlbum(
              this.widget.pray.idPray, this.widget.fileName);
          this.widget.onItemDeleted(this.widget.fileName);
        }
        break;
    }
    Navigator.pop(context);
  }
}
