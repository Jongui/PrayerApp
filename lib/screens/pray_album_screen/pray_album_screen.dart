import 'dart:io';

import 'package:flutter/material.dart';
import 'package:prayer_app/components/buttons/float_album_button.dart';
import 'package:prayer_app/components/dialogs/process_dialog.dart';
import 'package:prayer_app/localizations.dart';
import 'package:prayer_app/model/pray.dart';
import 'package:prayer_app/screens/image_picker_screen/image_picker_screen.dart';
import 'package:prayer_app/screens/loading_screen/loading_view.dart';
import 'package:prayer_app/utils/pray_firebase.dart';

class PrayAlbumScreen extends StatelessWidget{

  Pray pray;
  String token;

  PrayAlbumScreen({@required this.pray, @required this.token});

  @override
  Widget build(BuildContext context) {
    return PrayAlbumScreenState(pray, token);
  }

}

class PrayAlbumScreenState extends StatefulWidget{

  Pray pray;
  String token;
  PrayAlbumScreenState(this.pray, this.token);

  @override
  _PrayAlbumScreenState createState() => _PrayAlbumScreenState();

}

class _PrayAlbumScreenState extends State<PrayAlbumScreenState>{

  Widget _view;
  File _newImage;
  String _newImageDescription;


  @override
  void initState() {
    _newImage = null;
    _newImageDescription = '';
    _view = LoadingView();
    _handleImagesLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prays'),
      ),
      body: _view,
      floatingActionButton: FloatAlbumButton(
        onAddPicturePressed: () {
          Navigator.of(context).push(new MaterialPageRoute(
              builder: (context) => ImagePickerScreen(
                onImagePicked: (filePath) async {
                  _newImage = File(filePath);
                  setState(() {

                  });
                },
                onDescriptionChanged: (newDescription){
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

  _uploadImage() async{
    if(_newImage != null){
      showDialog(
          context: context,
          builder: (_) => ProcessDialog(
            text: AppLocalizations.of(context).uploadingPicture,
          ));
      await PrayFirebase().uploadPrayAlbumPicture(this.widget.pray.idPray, _newImage, _newImageDescription);
      Navigator.pop(context);
    }
  }

  void _handleImagesLoad() async{
//    StorageReference ref = await PrayFirebase().downloadPrayAlbum(this.widget.pray.idPray);
//    FirebaseStorage storage = await ref.getStorage();
//    String bucket = storage.storageBucket;
  }

}