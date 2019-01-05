import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as im;
import 'package:path_provider/path_provider.dart';
import 'package:prayer_app/components/buttons/float_image_picker_button.dart';
import 'package:prayer_app/components/dialogs/process_dialog.dart';
import 'package:prayer_app/components/inputs/small_input_field_area.dart';
import 'package:prayer_app/localizations.dart';
import 'package:prayer_app/screens/take_picture_screen/take_picture_screen.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerScreen extends StatelessWidget {
  final ValueChanged<String> onImagePicked;
  final ValueChanged<String> onDescriptionChanged;
  final VoidCallback onUploadPressed;
  String fileAddress;

  ImagePickerScreen({@required this.onImagePicked, @required this.fileAddress,
    @required this.onDescriptionChanged, @required this.onUploadPressed});

  @override
  Widget build(BuildContext context) {
    return ImagePickerScreenState(onImagePicked, fileAddress, onDescriptionChanged, onUploadPressed);
  }
}

class ImagePickerScreenState extends StatefulWidget {
  final ValueChanged<String> onImagePicked;
  String fileAddress;
  ValueChanged<String> onDescriptionChanged;
  VoidCallback onUploadPressed;

  ImagePickerScreenState(this.onImagePicked, this.fileAddress,
      this.onDescriptionChanged, this.onUploadPressed);

  _ImagePickerScreenState createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreenState> {
  Widget _view;
  String _newFileAddress;
  TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    _buildImageView();
    _descriptionController.addListener(_onDescriptionChanged);
    super.initState();
  }

  @override
  void dispose() {
    _newFileAddress = '';
    super.dispose();
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
          onUploadPressed: () {
            this.widget.onUploadPressed();
            Navigator.pop(context);
          },
          onFileSystemClicked: () async {
            File image =
                await ImagePicker.pickImage(source: ImageSource.gallery);
            if(image != null){
              setState(() {
                _newFileAddress = image.path;
                _buildImageView();
                this.widget.onImagePicked(image.path);
              });
            }
          },
          onRotateImageClicked: () async {
            if (_newFileAddress == null || _newFileAddress == '') return;
            showDialog(
                context: context,
                builder: (_) => ProcessDialog(
                      text: AppLocalizations.of(context).rotatingImage,
                    ));
            File _fileImage = File(_newFileAddress);
            List<int> _bytes = _fileImage.readAsBytesSync();
            im.Image tmpImage = im.decodeImage(_bytes);
            tmpImage = im.copyRotate(tmpImage, -90);
            final Directory extDir = await getApplicationDocumentsDirectory();
            final String dirPath = '${extDir.path}/Pictures';
            await Directory(dirPath).create(recursive: true);
            final String filePath = '$dirPath/${timestamp()}.jpg';
            File _newFile =
                await File(filePath).writeAsBytes(im.encodeJpg(tmpImage));
            _fileImage.delete();
            setState(() {
              _newFileAddress = _newFile.path;
              _buildImageView();
              this.widget.onImagePicked(_newFileAddress);
              Navigator.pop(context);
            });
          },
        ));
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  void _buildImageView() {
    ImageProvider _image;
    try {
      if (_newFileAddress != null) {
        _image = FileImage(File(_newFileAddress));
      } else {
        _image = NetworkImage(this.widget.fileAddress);
      }
    } catch (e) {
      _image = AssetImage("assets/pray.jpg");
    }
    _view = SingleChildScrollView(
        child: Column(
        children: <Widget>[
          Image(image: _image),
          Container(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: SmallInputFieldArea(
              controller: _descriptionController,
            ),
          ),
        ],
    ));
  }

  void _onDescriptionChanged() {
    this.widget.onDescriptionChanged(_descriptionController.text);
  }

}
