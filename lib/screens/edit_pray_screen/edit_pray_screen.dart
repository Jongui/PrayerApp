import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:prayer_app/components/buttons/save_button.dart';
import 'package:prayer_app/components/inputs/date_picker.dart';
import 'package:prayer_app/components/inputs/input_field_area.dart';
import 'package:prayer_app/model/pray.dart';
import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/utils/pray_http.dart';
import 'package:prayer_app/utils/user_pray_http.dart';

class EditPrayScreen extends StatelessWidget {

  Pray pray;
  User user;

  EditPrayScreen({@required this.pray, @required this.user});

  @override
  Widget build(BuildContext context) {
    return EditPrayScreenState(pray, user);
  }

}

class EditPrayScreenState extends StatefulWidget {

  EditPrayScreenState(this.pray, this.user, {Key key}) : super(key: key);
  Pray pray;
  User user;

  @override
  _EditPrayScreenState createState() => _EditPrayScreenState(pray, user);

}

class _EditPrayScreenState extends State<EditPrayScreenState>{

  TextEditingController _descriptionController = new TextEditingController();

  Pray pray;
  User user;

  String _newDescription = '';
  String _newStartDate = '';
  String _newEndDate = '';
  Size _screenSize;
  String _valueStartDate;
  String _valueEndDate;

  DatePicker _startDatePicker;
  DatePicker _endDatePicker;


  _EditPrayScreenState(this.pray, this.user);

  @override
  void initState() {
    var formatterTo = new DateFormat('dd/MM/yyyy');
    _valueStartDate = formatterTo.format(pray.beginDate);
    _valueEndDate = formatterTo.format(pray.endDate);
    _startDatePicker = DatePicker(value: _valueStartDate,
        onPressed: _startDatePicked);
    _endDatePicker = DatePicker(value: _valueEndDate,
        onPressed: _endDatePicked);
    _descriptionController.addListener(_onDescriptionChanged);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit your pray'),
      ),
      body: Builder(builder: (context) => _buildInputForm(context)),
    );

  }

  void _onDescriptionChanged(){
    _newDescription = _descriptionController.text;
  }

  Widget _buildInputForm(BuildContext context){
    _screenSize = MediaQuery.of(context).size;
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
        hint: 'Description',
        obscure: false,
        controller: _descriptionController,
        labelText: 'Description:',
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
      _startDatePicker = DatePicker(value: _valueStartDate,
          onPressed: _startDatePicked);
    });
  }

  _endDatePicked(String newValue){
    setState(() {
      _newEndDate = _valueEndDate = newValue;
      _endDatePicker = DatePicker(value: _valueEndDate,
          onPressed: _endDatePicked);
    });
  }

  _savedButtonPressed(BuildContext context) async{
    if(_newDescription == '' || _newStartDate == '')
      return;
    var formatterFrom = new DateFormat('dd/MM/yyyy');
    if(_newDescription != '')
      pray.description = _newDescription;
    if(_newStartDate != '')
      pray.beginDate = formatterFrom.parse(_newStartDate);
    if(_newEndDate != '')
      pray.endDate = formatterFrom.parse(_newEndDate);

    pray.idUser = user.idUser;

    Response response = await PrayHttp().putPray(pray, user.token);
    if(response.statusCode == 200 || response.statusCode == 201) {
      var jsonVar = json.decode(response.body);
      pray = Pray.fromJson(jsonVar);
      response =
      await UserPrayHttp().postUserPray(user, pray, pray.beginDate, pray.endDate);
    }
    if(response.statusCode == 200 || response.statusCode == 201){
      final snackBar = SnackBar(
        content: Text('Pray created!',
          style: TextStyle(
              color: Colors.green
          ),
        ),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        content: Text('Error while saving',
          style: TextStyle(
              color: Colors.red
          ),
        ),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

}