import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:prayer_app/components/buttons/float_album_button.dart';
import 'package:prayer_app/components/cardviews/album_picture_card_view.dart';
import 'package:prayer_app/localizations.dart';
import 'package:prayer_app/model/church.dart';
import 'package:prayer_app/screens/image_picker_screen/image_picker_screen.dart';
import 'package:prayer_app/screens/loading_screen/loading_view.dart';
import 'package:prayer_app/utils/church_firebase.dart';

class ChurchAlbumScreen extends StatelessWidget {
  Church church;
  String token;

  ChurchAlbumScreen({@required this.church, @required this.token});

  @override
  Widget build(BuildContext context) {
    return ChurchAlbumScreenState(church, token);
  }
}

class ChurchAlbumScreenState extends StatefulWidget {
  Church church;
  String token;

  ChurchAlbumScreenState(this.church, this.token);

  _ChurchAlbumScreenState createState() => _ChurchAlbumScreenState();
}

class _ChurchAlbumScreenState extends State<ChurchAlbumScreenState> {
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
        title: Text(AppLocalizations.of(context).churches),
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
      Future fut = ChurchFirebase().uploadChurchAlbumPicture(
        this.widget.church.idChurch,
        _newImage,
        _newImageDescription,
      );
      fut.then((mapValues) {
        Navigator.pop(context);
        setState(() {
          _widgets = List.from(_widgets)
            ..add(AlbumPictureCardView(
              fileName: mapValues['fileName'],
              pictureUrl: mapValues['downloadUrl'],
              onItemDeleted: (_fileName){
                _itemDeleted(_fileName);
              },
              church: this.widget.church,
            ));
          _widgets
              .sort((view1, view2) => view2.fileName.compareTo(view1.fileName));
          List<Widget> _newWidgets = [];
          _widgets.forEach((widget) async {
            _newWidgets.add(AlbumPictureCardView(
                pictureUrl: widget.pictureUrl,
                fileName: widget.fileName,
                onItemDeleted: widget.onItemDeleted,
                church: widget.church));
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

  void _handleImagesLoad() async {
    DatabaseReference _ref =
        await ChurchFirebase().downloadChurchAlbum(this.widget.church.idChurch);

    _ref.once().then((snapshot) {
      Map picture = snapshot.value;
      if (picture != null) {
        picture.forEach((key, value) {
          _widgets.add(AlbumPictureCardView(
            pictureUrl: value['fileAddress'],
            fileName: key,
            church: this.widget.church,
            onItemDeleted: (fileName){
              _itemDeleted(fileName);
            },
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
      _widgets
          .sort((view1, view2) => view2.fileName.compareTo(view1.fileName));
      List<Widget> _newWidgets = [];
      _widgets.forEach((widget) async {
        _newWidgets.add(AlbumPictureCardView(
            pictureUrl: widget.pictureUrl,
            fileName: widget.fileName,
            onItemDeleted: widget.onItemDeleted,
            church: widget.church));
      });
      _view = ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(20.0),
        children: _newWidgets,
      );
    });
  }
}
