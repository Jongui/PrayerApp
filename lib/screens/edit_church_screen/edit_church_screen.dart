import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:prayer_app/components/dialogs/process_dialog.dart';
import 'package:prayer_app/components/dropdown/country_dropdown_button.dart';
import 'package:prayer_app/components/inputs/input_field_area.dart';
import 'package:prayer_app/components/buttons/save_button.dart';
import 'package:prayer_app/localizations.dart';
import 'package:prayer_app/model/church.dart';
import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/screens/image_picker_screen/image_picker_screen.dart';
import 'package:prayer_app/utils/church_firebase.dart';
import 'package:prayer_app/utils/church_http.dart';

class EditChurchScreen extends StatelessWidget {
  Church church;
  User user;

  EditChurchScreen({@required this.church, @required this.user});

  @override
  Widget build(BuildContext context) {
    return EditChurchScreenState(
      church: church,
      user: user,
    );
  }
}

class EditChurchScreenState extends StatefulWidget {
  EditChurchScreenState({Key key, this.church, this.user}) : super(key: key);

  final Church church;
  final User user;

  @override
  _EditChurchScreenState createState() =>
      new _EditChurchScreenState(church, user);
}

class _EditChurchScreenState extends State<EditChurchScreenState> {
  _EditChurchScreenState(this.church, this.user);

  Church church;
  User user;

  TextEditingController _churchNameController = new TextEditingController();
  TextEditingController _cityController = new TextEditingController();

  String _newChurchName = '';
  Size _screenSize;
  String _newCountry = '';
  String _currentCountry;
  String _newCity = '';
  AppLocalizations _appLocalizations;
  String _language;
  ImageProvider _profileImageProvider;
  File _newFile;
  String _profilePictureDescription;
  String _imageUrl;

  @override
  initState() {
    _profilePictureDescription = '';
    _profileImageProvider = AssetImage("assets/church_background.jpg");
    _churchNameController.addListener(_onChurchNameChanged);
    _cityController.addListener(_onCityChanged);
    downloadFirebaseChurchProfileImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _appLocalizations = AppLocalizations.of(context);
    _screenSize = MediaQuery.of(context).size;
    Locale locale = Localizations.localeOf(context);
    _language = locale.languageCode;
    return Scaffold(
      appBar: AppBar(
        title: Text(_appLocalizations.title),
      ),
      body: Builder(builder: (context) => _buildInputForm(context)),
    );
  }

  Widget _buildInputForm(BuildContext context) {
    EditChurchScreenState state = this.widget;
    if (_newCountry == '')
      _currentCountry = church.country;
    else
      _currentCountry = _newCountry;
    return SingleChildScrollView(
      child: Container(
        width: _screenSize.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  _buildChurchProfilePicture(),
                  _buildChurchNameInputField(state.church.name),
                  _buildCityInputField(state.church.city),
                  _buildCountryDropDownButton(),
                  _buildBarButton(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onChurchNameChanged() {
    _newChurchName = _churchNameController.text;
  }

  void _onCityChanged() {
    _newCity = _cityController.text;
  }

  Widget _buildChurchNameInputField(String name) {
    return Container(
      padding:
          EdgeInsets.only(left: 24.0, right: 24.0, top: 12.0, bottom: 10.0),
      child: InputFieldArea(
        hint: name,
        obscure: false,
        controller: _churchNameController,
        labelText: _appLocalizations.churchName,
      ),
    );
  }

  Widget _buildCityInputField(String city) {
    return Container(
        padding:
            EdgeInsets.only(left: 24.0, right: 24.0, top: 12.0, bottom: 10.0),
        child: InputFieldArea(
          hint: city,
          obscure: false,
          controller: _cityController,
          labelText: _appLocalizations.city,
        ));
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
    if (_newChurchName == '' &&
        _newCountry == '' &&
        _newCity == '' &&
        _newFile == null) return;
    if (_newChurchName != '') church.name = _newChurchName;
    if (_newCountry != '') church.country = _newCountry;
    if (_newCity != '') church.city = _newCity;
    showDialog(
        context: context,
        builder: (_) => ProcessDialog(
              text: AppLocalizations.of(context).savingChurch,
            ));

    church.changedAt = DateTime.now();
    church.changedBy = user.idUser;

    if (_newFile != null) {
      await ChurchFirebase().uploadChurchProfilePicture(
          this.widget.church.idChurch, _newFile, _profilePictureDescription);
    }

    int response = await ChurchHttp().putChurch(church, user.token);
    if (response == 200) {
      final snackBar = SnackBar(
        content: Text(
          _appLocalizations.churchUpdated,
          style: TextStyle(color: Colors.green),
        ),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        content: Text(
          _appLocalizations.errorWhileSaving,
          style: TextStyle(color: Colors.red),
        ),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }
    Navigator.pop(context);
  }

  Widget _buildCountryDropDownButton() {
    return Container(
      height: 120.0,
      padding:
          EdgeInsets.only(left: 24.0, right: 24.0, top: 12.0, bottom: 10.0),
      child: CountryDropdownButton(
        _currentCountry,
        languageLowerCase: _language.toLowerCase(),
        onChanged: (newCountry) {
          setState(() {
            _newCountry = newCountry.code;
          });
        },
      ),
    );
  }

  Widget _buildChurchProfilePicture() {
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
                          onUploadPressed: () {},
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

  void downloadFirebaseChurchProfileImage() async {
    StorageReference ref = await ChurchFirebase()
        .downloadChurchProfilePicture(this.widget.church.idChurch);
    String _imageUrlLocal = await ref.getDownloadURL();
    setState(() {
      if (_imageUrlLocal != null) {
        _profileImageProvider = NetworkImage(_imageUrlLocal);
        _imageUrl = _imageUrlLocal;
      }
    });
  }
}
