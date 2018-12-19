import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:prayer_app/components/inputs/date_picker.dart';
import 'package:prayer_app/components/inputs/input_field_area.dart';
import 'package:prayer_app/components/buttons/save_button.dart';
import 'package:prayer_app/localizations.dart';
import 'package:prayer_app/model/pray.dart';
import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/utils/pray_http.dart';
import 'package:prayer_app/utils/user_pray_http.dart';

class AddPrayScreen extends StatelessWidget {

  User user;

  AddPrayScreen({@required this.user});

  @override
  Widget build(BuildContext context) {
    return AddPrayScreenState(
      user: user,);
  }

}

class AddPrayScreenState extends StatefulWidget {

  AddPrayScreenState({Key key, this.user}) : super(key: key);

  final User user;

  @override
  _AddPrayScreenState createState() => new _AddPrayScreenState(user);

}

class _AddPrayScreenState extends State<AddPrayScreenState>{
  TextEditingController _descriptionController = new TextEditingController();

  User user;

  String _newDescription = '';
  String _newStartDate = '';
  String _newEndDate = '';
  Size _screenSize;
  Pray _pray = Pray();
  String _valueStartDate;
  String _valueEndDate;
  AppLocalizations _appLocalizations;
  DatePicker _startDatePicker;
  DatePicker _endDatePicker;

  _AddPrayScreenState(this.user);

  @override
  initState(){
    super.initState();
    _descriptionController.addListener(_onDescriptionChanged);
  }

  @override
  Widget build(BuildContext context) {
    _appLocalizations = AppLocalizations.of(context);
    if(_valueStartDate == null){
      _valueStartDate = _appLocalizations.startDate;
    }
    if(_valueEndDate == null){
      _valueEndDate = _appLocalizations.endDate;
    }
    _screenSize = MediaQuery.of(context).size;
    _startDatePicker = DatePicker(value: _valueStartDate,
        onPressed: _startDatePicked);
    _endDatePicker = DatePicker(value: _valueEndDate,
        onPressed: _endDatePicked);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).addYourPray),
      ),
      body: Builder(builder: (context) => _buildInputForm(context)),
    );

  }

  void _onDescriptionChanged(){
    _newDescription = _descriptionController.text;
  }

  Widget _buildInputForm(BuildContext context){
    return SingleChildScrollView(
      child: Container(
        width: _screenSize.width,
        height: _screenSize.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Form(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
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

  Widget _buildDescriptionInputField(){
    return Container(
      padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 12.0, bottom: 10.0),
      child: InputFieldArea(
        hint: _appLocalizations.description,
        obscure: false,
        controller: _descriptionController,
        labelText: _appLocalizations.description + ':',
      ),
    );
  }

  Widget _buildStartDatePicker(){
    return _startDatePicker;
  }

  Widget _buildEndDatePicker(){
    return _endDatePicker;
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

  _startDatePicked(String newValue){
    setState(() {
      _newStartDate = _valueStartDate = newValue;
    });
  }

  _endDatePicked(String newValue){
    setState(() {
      _newEndDate = _valueEndDate = newValue;
    });
  }

  _savedButtonPressed(BuildContext context) async{
    if(_newDescription == '' || _newStartDate == '')
      return;
    var formatterFrom = new DateFormat('dd/MM/yyyy');
    if(_newDescription != '')
      _pray.description = _newDescription;
    if(_newStartDate != '')
      _pray.beginDate = formatterFrom.parse(_newStartDate);
    if(_newEndDate != '')
      _pray.endDate = formatterFrom.parse(_newEndDate);

    _pray.idUser = user.idUser;

    Response response = await PrayHttp().postPray(_pray, user.token);
    if(response.statusCode == 201) {
      var jsonVar = json.decode(response.body);
      _pray = Pray.fromJson(jsonVar);
      response =
      await UserPrayHttp().postUserPray(user, _pray, _pray.beginDate, _pray.endDate,
      user.token);
    }
    if(response.statusCode == 200 || response.statusCode == 201){
      final snackBar = SnackBar(
        content: Text(_appLocalizations.prayCreated,
          style: TextStyle(
              color: Colors.green
          ),
        ),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        content: Text(_appLocalizations.errorWhileSaving,
          style: TextStyle(
              color: Colors.red
          ),
        ),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }
}