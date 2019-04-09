import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as im;
import 'package:path_provider/path_provider.dart';
import 'package:prayer_app/components/buttons/float_image_picker_button.dart';
import 'package:prayer_app/components/dialogs/process_dialog.dart';
import 'package:prayer_app/components/inputs/small_input_field_area.dart';
import 'package:prayer_app/localizations.dart';
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
  FocusNode _focusNode;

  TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    _buildImageView();
    _descriptionController.addListener(_onDescriptionChanged);
    _focusNode = FocusNode();
    _focusNode.addListener((){
      setState(() {

      });
    });

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
        floatingActionButton: _focusNode.hasFocus == false ? FloatImagePickerButton(
          onCameraClicked: () async {
            showDialog(
                context: context,
                builder: (_) => ProcessDialog(
                  text: AppLocalizations.of(context).takingPicture,
                ));
            File image = await ImagePicker.pickImage(source: ImageSource.camera);
            if(image != null){
              im.Image _tmpImage = im.decodeImage(image.readAsBytesSync());
              im.Image _resizedImg = im.copyResize(_tmpImage, 800);
              image = File(image.path)
                ..writeAsBytesSync(im.encodeJpg(_resizedImg));
              setState((){
                _newFileAddress = image.path;
                _buildImageView();
                this.widget.onImagePicked(image.path);
              });
            }
            Navigator.pop(context);
          },
          onUploadPressed: () {
            showDialog(
                context: context,
                builder: (_) => ProcessDialog(
                  text: AppLocalizations.of(context).uploadingPicture,
                ));
            this.widget.onUploadPressed();
          },
          onFileSystemClicked: () async {
            File image =
                await ImagePicker.pickImage(source: ImageSource.gallery);
            final directory = await getApplicationDocumentsDirectory();
            final path = directory.path;
            if(image != null){
              final names = image.path.split('/');
              int lastIndex = names.length - 1;
              final fileName = names[lastIndex];
              im.Image _tmpImage = im.decodeImage(image.readAsBytesSync());
              im.Image _resizedImg = im.copyResize(_tmpImage, 800);
              image = File('$path/$fileName')
                ..writeAsBytesSync(im.encodeJpg(_resizedImg));
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
        ): null
    );
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
    _view = LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints){
        double _height = constraints.maxHeight * 0.9;
        return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Image(image: _image,
                  height: _height,),
                Container(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: SmallInputFieldArea(
                    controller: _descriptionController,
                    focusNode: _focusNode,
                  ),
                ),
              ],
            ));
      },
    );
  }

  void _onDescriptionChanged() {
    this.widget.onDescriptionChanged(_descriptionController.text);
  }

}
