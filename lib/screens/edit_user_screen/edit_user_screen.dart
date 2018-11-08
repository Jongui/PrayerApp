import 'package:flutter/material.dart';
import 'package:prayer_app/components/input_field_area.dart';
import 'package:prayer_app/components/save_button.dart';
import 'package:prayer_app/model/church.dart';
import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/utils/church_http.dart';
import 'package:prayer_app/utils/user_http.dart';

class EditUserScreen extends StatelessWidget {

  User user;

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

class _EditUserScreenState extends State<EditUserScreenState>{

  final String _loading = 'Loading';
  TextEditingController _userNameController = new TextEditingController();
  TextEditingController _countryController = new TextEditingController();

  String _churchName = '';
  Size _screenSize;
  String _newName = '';
  String _newCountry = '';
  User _user;

  @override
  initState(){
    super.initState();
    _userNameController.addListener(_onUserNameChanged);
    _countryController.addListener(_onCountryChanged);
    _churchName = _loading;
  }

  @override
  Widget build(BuildContext context) {
    _user = this.widget.user;
    if(_churchName == _loading)
      _loadChurch(_user.church, _user.token);
    _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Prays App'),
      ),
      body: Builder(builder: (context) => _buildInputForm(context)),
    );
  }

  void _onUserNameChanged(){
    _newName = _userNameController.text;
  }

  void _onCountryChanged(){
    _newCountry = _countryController.text;
  }

  Widget _buildInputForm(BuildContext context){
    Size screenSize = MediaQuery.of(context).size;
    EditUserScreenState state = this.widget;
    return Container(
      width: screenSize.width,
      height: screenSize.height,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Form(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  _buildUserNameInputField(state.user.userName),
                  _buildCountryInputField(state.user.country),
                  //_buildChurchInputField(_churchName),
                  _buildBarButton(context),
                ],
              ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserNameInputField(String userName){
    return Container(
      padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 12.0, bottom: 10.0),
      child: InputFieldArea(
        hint: userName,
        obscure: false,
        controller: _userNameController,
        labelText: 'User Name:',
      ),
    );
  }

  Widget _buildCountryInputField(String country){
    return Container(
        padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 12.0, bottom: 10.0),
        child: InputFieldArea(
          hint: country,
          obscure: false,
          controller: _countryController,
          labelText: 'Country:',
        )
    );
  }

//  Widget _buildChurchInputField(String church){
//    _dropDownMenuItems = new List();
//    _dropDownMenuItems.add(DropdownMenuItem(
//        value: _loading,
//        child: Text(_loading)
//      )
//    );
//    return Container(
//      padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 12.0, bottom: 10.0),
//        child:  DropdownButton(
//          value: _loading,
//          items: _dropDownMenuItems,
//          onChanged: (church) {
//            print(church);
//        }
//        ),
//    );
//  }

  _loadChurch(int idChurch, String token) async {
    Church church = await ChurchHttp().fetchChurch(idChurch, token);
    setState(() {
      _churchName = church.name;
    });
  }

  Widget _buildBarButton(BuildContext context){
    return Container(
      padding: EdgeInsets.only(top: 24.0, left: 84.0),
      child: Row(
          children: <Widget>[
            SaveButton(
              height: 50.0,
              width: _screenSize.width / 2,
              onPressed: () =>_savedButtonPressed(context),
            ),
          ],
        )
    );
  }

  _savedButtonPressed(BuildContext context) async{
    if(_newName == '' && _newCountry == '')
      return;
    if(_newName != '')
      _user.userName = _newName;
    if(_newCountry != '')
      _user.country = _newCountry;
    int response = await UserHttp().putUser(_user);
    if(response == 200){
      final snackBar = SnackBar(
        content: Text('User updated!',
        style: TextStyle(
            color: Colors.green
          ),
        ),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        content: Text('Error while updating',
          style: TextStyle(
              color: Colors.red
          ),
        ),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

}