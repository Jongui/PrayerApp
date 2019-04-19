import 'dart:async';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:prayer_app/components/buttons/float_album_button.dart';
import 'package:prayer_app/components/cardviews/album_picture_card_view.dart';
import 'package:prayer_app/components/dialogs/ok_dialog.dart';
import 'package:prayer_app/localizations.dart';
import 'package:prayer_app/model/pray.dart';
import 'package:prayer_app/screens/image_picker_screen/image_picker_screen.dart';
import 'package:prayer_app/screens/loading_screen/loading_view.dart';
import 'package:prayer_app/utils/firebase_messaging_utils.dart';
import 'package:prayer_app/utils/pray_firebase.dart';

class PrayAlbumScreen extends StatelessWidget {
  Pray pray;
  String token;

  PrayAlbumScreen({@required this.pray, @required this.token});

  @override
  Widget build(BuildContext context) {
    return PrayAlbumScreenState(pray, token);
  }
}

class PrayAlbumScreenState extends StatefulWidget {
  Pray pray;
  String token;
  PrayAlbumScreenState(this.pray, this.token);

  @override
  _PrayAlbumScreenState createState() => _PrayAlbumScreenState();
}

class _PrayAlbumScreenState extends State<PrayAlbumScreenState> {
  Widget _view;
  File _newImage;
  String _newImageDescription;
  List<AlbumPictureCardView> _widgets = [];

  @override
  void initState() {
    _newImage = null;
    _newImageDescription = '';
    _view = LoadingView();
    _handleImagesLoad();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).prays),
      ),
      body: _view,
      floatingActionButton: FloatAlbumButton(
        onAddPicturePressed: () {
          Navigator.of(context).push(new MaterialPageRoute(
              builder: (context) => ImagePickerScreen(
                    onImagePicked: (filePath) async {
                      _newImage = File(filePath);
                      setState(() {});
                    },
                    onDescriptionChanged: (newDescription) {
                      _newImageDescription = newDescription;
                    },
                    onUploadPressed: () {
                      _uploadImage();
                    },
                    fileAddress: '',
                  )));
        },
      ),
    );
  }

  _uploadImage() async {
    if (_newImage != null) {
      Future fut = PrayFirebase().uploadPrayAlbumPicture(
        this.widget.pray.idPray,
        _newImage,
        _newImageDescription,
      );
      fut.then((mapValues) {
        Navigator.pop(context);
        _sendFirebaseMessage();
        showDialog<String>(
            context: context,
            builder: (BuildContext context) => OkDialog(
              text: AppLocalizations.of(context).imageUploaded,
              backgroundColor: Colors.green,
              icon: Icons.check,
            ));
        setState(() {
          _widgets = List.from(_widgets)
            ..add(AlbumPictureCardView(
              fileName: mapValues['fileName'],
              pictureUrl: mapValues['downloadUrl'],
              pray: this.widget.pray,
              onItemDeleted: (fileName) {
                _itemDeleted(fileName);
              },
            ));
          _widgets
              .sort((view1, view2) => view2.fileName.compareTo(view1.fileName));
          List<Widget> _newWidgets = [];
          _widgets.forEach((widget) async {
            _newWidgets.add(AlbumPictureCardView(
                pictureUrl: widget.pictureUrl,
                fileName: widget.fileName,
                onItemDeleted: (fileName) {
                  _itemDeleted(fileName);
                },
                pray: widget.pray));
          });
          _view = ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(20.0),
            children: _newWidgets,
          );
        });
      });
    }
  }

  _handleImagesLoad() async {
    DatabaseReference _ref =
        await PrayFirebase().downloadPrayAlbum(this.widget.pray.idPray);

    _ref.once().then((snapshot) {
      Map picture = snapshot.value;
      if (picture != null) {
        picture.forEach((key, value) {
          _widgets.add(AlbumPictureCardView(
            pictureUrl: value['fileAddress'],
            onItemDeleted: (fileName) {
              _itemDeleted(fileName);
            },
            fileName: key,
            pray: this.widget.pray,
          ));
        });
        _widgets
            .sort((view1, view2) => view2.fileName.compareTo(view1.fileName));
        _view = null;
        _view = ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(20.0),
          children: _widgets,
        );
      } else {
        _view = Text(AppLocalizations.of(context).noPicturesFound);
      }
      setState(() {});
    });
  }

  void _itemDeleted(String _fileName) {
    _widgets.removeWhere((view) => view.fileName == _fileName);

    setState(() {
      _widgets.sort((view1, view2) => view2.fileName.compareTo(view1.fileName));
      List<Widget> _newWidgets = [];
      _widgets.forEach((widget) async {
        _newWidgets.add(AlbumPictureCardView(
            pictureUrl: widget.pictureUrl,
            fileName: widget.fileName,
            onItemDeleted: widget.onItemDeleted,
            pray: widget.pray));
      });
      _view = ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(20.0),
        children: _newWidgets,
      );
    });
  }


  void _sendFirebaseMessage( ) {
    String _name = this.widget.pray.description;
    String _message =
        'New picture added to pray $_name';
    FirebaseMessagingUtils().sendToPrayTopic(
        this.widget.pray.idPray,
        'Pray album',
        _message,
        FirebaseMessagingUtils.PRAY_NOTIFICATION);
  }

}
