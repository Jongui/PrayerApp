import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prayer_app/components/buttons/save_button.dart';
import 'package:prayer_app/components/dialogs/ok_dialog.dart';
import 'package:prayer_app/components/dialogs/process_dialog.dart';
import 'package:prayer_app/components/inputs/date_picker.dart';
import 'package:prayer_app/components/inputs/input_field_area.dart';
import 'package:prayer_app/localizations.dart';
import 'package:prayer_app/model/pray.dart';
import 'package:prayer_app/screens/image_picker_screen/image_picker_screen.dart';
import 'package:prayer_app/utils/pray_firebase.dart';
import 'package:prayer_app/utils/pray_http.dart';

class EditPrayScreen extends StatefulWidget {
  String token;
  Pray pray;

  EditPrayScreen({@required this.token, @required this.pray});

  _EditPrayScreenState createState() => _EditPrayScreenState();

}

class _EditPrayScreenState extends State<EditPrayScreen> {
  TextEditingController _descriptionController = new TextEditingController();

  String _newDescription = '';
  String _newStartDate = '';
  String _newEndDate = '';
  Size _screenSize;
  String _description;
  String _valueStartDate;
  String _valueEndDate;
  DatePicker _startDatePicker;
  DatePicker _endDatePicker;
  ImageProvider _profileImageProvider;
  String _imageUrl;
  File _newFile;
  String _profilePictureDescription;

  final _formKey = GlobalKey<FormState>();

  _EditPrayScreenState();

  @override
  void initState() {
    _profilePictureDescription = '';

    _profileImageProvider = AssetImage("assets/pray.jpg");
    _downloadFirebasePrayProfileImage();

    _descriptionController.addListener(_onDescriptionChanged);
    var formatterFrom = new DateFormat('yyyy/MM/dd');
    var formatterTo = new DateFormat('dd/MM/yyyy');

    _valueStartDate = formatterFrom.format(this.widget.pray.beginDate);
    DateTime dateTime = formatterFrom.parse(_valueStartDate);
    _valueStartDate = formatterTo.format(dateTime);

    _valueEndDate = formatterFrom.format(this.widget.pray.endDate);
    dateTime = formatterFrom.parse(_valueEndDate);
    _valueEndDate = formatterTo.format(dateTime);

    _description = this.widget.pray.description;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_valueStartDate == null) {
      _valueStartDate = AppLocalizations.of(context).startDate;
    }
    if (_valueEndDate == null) {
      _valueEndDate = AppLocalizations.of(context).endDate;
    }
    _screenSize = MediaQuery.of(context).size;
    _startDatePicker =
        DatePicker(value: _valueStartDate, onPressed: _startDatePicked);
    _endDatePicker =
        DatePicker(value: _valueEndDate, onPressed: _endDatePicked);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).addYourPray),
      ),
      body: Builder(builder: (context) => _buildInputForm(context)),
    );
  }

  void _onDescriptionChanged() {
    _newDescription = _descriptionController.text;
  }

  Widget _buildInputForm(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: _screenSize.width,
        height: _screenSize.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  _buildPrayProfilePicture(),
                  _buildDescriptionInputField(),
                  _buildStartDatePicker(),
                  _buildEndDatePicker(),
                  _buildBarButton(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDescriptionInputField() {
    return Container(
      padding:
          EdgeInsets.only(left: 24.0, right: 24.0, top: 12.0, bottom: 10.0),
      child: InputFieldArea(
        validator: (value) {
          if (value.isEmpty && _description == '') {
            return AppLocalizations.of(context).mandatoryField;
          }
        },
        hint: _description,
        obscure: false,
        controller: _descriptionController,
        labelText: _description,
      ),
    );
  }

  Widget _buildStartDatePicker() {
    return _startDatePicker;
  }

  Widget _buildEndDatePicker() {
    return _endDatePicker;
  }

  _startDatePicked(String newValue) {
    setState(() {
      _newStartDate = _valueStartDate = newValue;
    });
  }

  _endDatePicked(String newValue) {
    setState(() {
      _newEndDate = _valueEndDate = newValue;
    });
  }

  Widget _buildBarButton(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 24.0, left: 84.0),
        child: Row(
          children: <Widget>[
            SaveButton(
              height: 50.0,
              width: _screenSize.width / 2,
              onPressed: () => _savedButtonPressed(context),
            ),
          ],
        ));
  }

  _savedButtonPressed(BuildContext context) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    if (_newDescription == '' &&
        _newStartDate == '' &&
        _newDescription == '' &&
        _newFile == null) return;
    var formatterFrom = new DateFormat('dd/MM/yyyy');
    if (_newDescription != '') this.widget.pray.description = _newDescription;
    if (_newStartDate != '')
      this.widget.pray.beginDate = formatterFrom.parse(_newStartDate);
    if (_newEndDate != '')
      this.widget.pray.endDate = formatterFrom.parse(_newEndDate);
    showDialog(
        context: context,
        builder: (_) => ProcessDialog(
              text: AppLocalizations.of(context).savingPray,
            ));

    if (_newFile != null) {
      await PrayFirebase().uploadPrayProfilePicture(
          this.widget.pray.idPray, _newFile, _profilePictureDescription);
    }

    int response =
        await PrayHttp().putPray(this.widget.pray, this.widget.token);
    if (response == 200 || response == 201) {
      showDialog<String>(
          context: context,
          builder: (BuildContext context) => OkDialog(
            text: AppLocalizations.of(context).prayEdited,
            backgroundColor: Colors.green,
            icon: Icons.check,
          )
      );
    } else {
      showDialog<String>(
          context: context,
          builder: (BuildContext context) => OkDialog(
            text: AppLocalizations.of(context).errorWhileSaving,
            backgroundColor: Colors.red,
            icon: Icons.error,
          )
      );
    }
    Navigator.pop(context);
  }

  Widget _buildPrayProfilePicture() {
    return Container(
      height: 220.0,
      padding: EdgeInsets.only(right: 10.0),
      decoration: new BoxDecoration(
          image:
              DecorationImage(image: _profileImageProvider, fit: BoxFit.fill)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
            child: FloatingActionButton(
              heroTag: 'cameraButton',
              onPressed: () {
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (context) => ImagePickerScreen(
                          onImagePicked: (filePath) async {
                            setState(() {
                              _newFile = File(filePath);
                              _profileImageProvider = FileImage(_newFile);
                            });
                          },
                          onUploadPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          onDescriptionChanged: (newDescription) {
                            _profilePictureDescription = newDescription;
                          },
                          fileAddress: _imageUrl,
                        )));
              },
              tooltip: 'Camera',
              child: Icon(Icons.camera_alt),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }

  void _downloadFirebasePrayProfileImage() async {
    StorageReference ref = await PrayFirebase()
        .downloadPrayProfilePicture(this.widget.pray.idPray);
    _imageUrl = await ref.getDownloadURL();
    setState(() {
      if (_imageUrl != null) {
        _profileImageProvider = NetworkImage(_imageUrl);
      }
    });
  }
}
