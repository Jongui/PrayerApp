import 'dart:io';

import 'package:flutter/material.dart';
import 'package:prayer_app/components/buttons/float_image_picker_button.dart';
import 'package:prayer_app/localizations.dart';
import 'package:prayer_app/screens/take_picture_screen/take_picture_screen.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerScreen extends StatelessWidget {
  final ValueChanged<String> onImagePicked;
  String fileAddress;

  ImagePickerScreen({@required this.onImagePicked, @required this.fileAddress});

  @override
  Widget build(BuildContext context) {
    return ImagePickerScreenState(onImagePicked, fileAddress);
  }
}

class ImagePickerScreenState extends StatefulWidget {
  final ValueChanged<String> onImagePicked;
  String fileAddress;

  ImagePickerScreenState(this.onImagePicked, this.fileAddress);

  _ImagePickerScreenState createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreenState> {
  Widget _view;
  String _newFileAddress;

  @override
  void initState() {
    _buildImageView();
    super.initState();
  }

  @override
  void dispose() {
    _newFileAddress = '';
    super.dispose();
  }

  @override
  void deactivate() {
    _newFileAddress = '';
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(AppLocalizations.of(context).title)),
        body: _view,
        floatingActionButton: FloatImagePickerButton(
          onCameraClicked: () {
            Navigator.of(context).push(new MaterialPageRoute(
                builder: (context) => TakePictureScreen(
                      onTakePicture: (newFileAddress) {
                        setState(() {
                          _newFileAddress = newFileAddress;
                          _buildImageView();
                          this.widget.onImagePicked(newFileAddress);
                          Navigator.pop(context);
                        });
                      },
                    )));
          },
          onFileSystemClicked: () async {
            File image =
                await ImagePicker.pickImage(source: ImageSource.gallery);
            setState(() {
              _newFileAddress = image.path;
              _buildImageView();
              this.widget.onImagePicked(image.path);
            });
          },
        ));
  }

  void _buildImageView() {
    ImageProvider _image = NetworkImage(this.widget.fileAddress);
    if (_newFileAddress != null) {
      _image = FileImage(File(_newFileAddress));
    }
    _view = Image(image: _image);
  }
}
