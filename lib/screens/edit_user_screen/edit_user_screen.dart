import 'dart:io';

import 'package:flutter/material.dart';
import 'package:prayer_app/components/dialogs/process_dialog.dart';
import 'package:prayer_app/components/dropdown/church_dropdown_button.dart';
import 'package:prayer_app/components/dropdown/country_dropdown_button.dart';
import 'package:prayer_app/components/inputs/input_field_area.dart';
import 'package:prayer_app/components/buttons/save_button.dart';
import 'package:prayer_app/localizations.dart';
import 'package:prayer_app/model/church.dart';
import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/screens/image_picker_screen/image_picker_screen.dart';
import 'package:prayer_app/screens/loading_screen/loading_view.dart';
import 'package:prayer_app/utils/church_http.dart';
import 'package:prayer_app/utils/user_firebase_storage.dart';
import 'package:prayer_app/utils/user_http.dart';

class EditUserScreen extends StatelessWidget {
  final User user;

  EditUserScreen(this.user);

  @override
  Widget build(BuildContext context) {
    return EditUserScreenState(user: user);
  }
}

class EditUserScreenState extends StatefulWidget {
  EditUserScreenState({Key key, this.user}) : super(key: key);

  final User user;

  @override
  _EditUserScreenState createState() => new _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreenState> {
  TextEditingController _userNameController = new TextEditingController();
  TextEditingController _countryController = new TextEditingController();

  Church _church;
  Size _screenSize;
  String _newName = '';
  String _newCountry = '';
  int _newIdChurch = 0;
  String _currentCountry;
  String _newAvatarUrl = '';
  User _user;
  List<Church> _churchList = List();
  String _language;
  String _profilePictureDescription;

  @override
  initState() {
    super.initState();
    _userNameController.addListener(_onUserNameChanged);
    _countryController.addListener(_onCountryChanged);
  }

  @override
  void dispose() {
    _newAvatarUrl = '';
    super.dispose();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    _user = this.widget.user;
    if (_newCountry == '')
      _currentCountry = _user.country;
    else
      _currentCountry = _newCountry;
    _screenSize = MediaQuery.of(context).size;
    Locale locale = Localizations.localeOf(context);
    _language = locale.languageCode;
    if (_churchList.length > 0)
      return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).editUser),
        ),
        body: Builder(builder: (context) => _buildInputForm(context)),
      );
    else
      _loadChurch(_user.church, _user.token);
    return LoadingView();
  }

  void _onUserNameChanged() {
    _newName = _userNameController.text;
  }

  void _onCountryChanged() {
    _newCountry = _countryController.text;
  }

  Widget _buildInputForm(BuildContext context) {
    return Container(
      width: _screenSize.width,
      height: _screenSize.height,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Form(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _buildUserAvatarInputField(_user.avatarUrl, context),
                _buildUserNameInputField(_user.userName),
                _buildChurchInputField(_churchList),
                _buildCountryDropDownButton(),
                _buildBarButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserNameInputField(String userName) {
    return Container(
      padding:
          EdgeInsets.only(left: 24.0, right: 24.0, top: 12.0, bottom: 10.0),
      child: InputFieldArea(
        hint: userName,
        obscure: false,
        controller: _userNameController,
        labelText: 'User Name:',
      ),
    );
  }

  _loadChurch(int idChurch, String token) async {
    _churchList = await ChurchHttp().getChurches();
    setState(() {
      for (int i = 0; i < _churchList.length; i++) {
        Church church = _churchList.elementAt(i);
        if (church.idChurch == _user.church) {
          _church = church;
          break;
        }
      }
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
    if (_newName == '' &&
        _newCountry == '' &&
        _newIdChurch == 0 &&
        _newAvatarUrl == '') return;
    showDialog(
        context: context,
        builder: (_) => ProcessDialog(
              text: AppLocalizations.of(context).savingUser,
            ));
    if (_newName != '') _user.userName = _newName;
    if (_newCountry != '') _user.country = _newCountry;
    if (_newIdChurch != 0) _user.church = _newIdChurch;
    if (_newAvatarUrl != '') {
      _user.avatarUrl = await UserFirebaseStorage()
          .uploadUserProfilePicture(_user.idUser, File(_newAvatarUrl),
          _profilePictureDescription);
    }

    int response = await UserHttp().putUser(_user);
    if (response == 200) {
      final snackBar = SnackBar(
        content: Text(
          AppLocalizations.of(context).userUpdated,
          style: TextStyle(color: Colors.green),
        ),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        content: Text(
          AppLocalizations.of(context).errorWhileSaving,
          style: TextStyle(color: Colors.red),
        ),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }
    _newAvatarUrl = '';
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

  Widget _buildChurchInputField(List<Church> churchList) {
    return Container(
        height: 120.0,
        padding:
            EdgeInsets.only(left: 24.0, right: 24.0, top: 12.0, bottom: 10.0),
        child: ChurchDropdownButton(_church, churches: _churchList,
            onChanged: (newChurch) {
          setState(() {
            _church = newChurch;
            _newIdChurch = newChurch.idChurch;
          });
        }));
  }

  Widget _buildUserAvatarInputField(String avatarUrl, BuildContext context) {
    ImageProvider avatarImage = NetworkImage(avatarUrl);
    if (_newAvatarUrl != '') {
      avatarImage = FileImage(File(_newAvatarUrl));
    }
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(new MaterialPageRoute(
              builder: (context) => ImagePickerScreen(
                    onImagePicked: (filePath) {
                      setState(() {
                        _newAvatarUrl = filePath;
                      });
                    },
                    onDescriptionChanged: (newDescription){
                      _profilePictureDescription = newDescription;
                    },
                    onUploadPressed: (){

                    },
                    fileAddress: this.widget.user.avatarUrl,
                  )));
        },
        child: Stack(
          alignment: const Alignment(0.0, 0.8),
          children: [
            CircleAvatar(
              radius: 60.0,
              backgroundColor: Colors.grey,
              backgroundImage: avatarImage != null ? avatarImage : null,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black45,
              ),
              child: Text(
                AppLocalizations.of(context).edit,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ));
  }
}
