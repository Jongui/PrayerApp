import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prayer_app/components/date_picker.dart';
import 'package:prayer_app/components/input_field_area.dart';
import 'package:prayer_app/components/save_button.dart';
import 'package:prayer_app/model/pray.dart';
import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/utils/pray_http.dart';

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
  _AddPrayScreenState createState() => new _AddPrayScreenState();

}

class _AddPrayScreenState extends State<AddPrayScreenState>{
  TextEditingController _descriptionController = new TextEditingController();

  String _newDescription = '';
  String _newStartDate = '';
  String _newEndDate = '';
  Size _screenSize;
  Pray _pray = Pray();
  User _user;
  String _valueStartDate = 'Start Date';
  String _valueEndDate = 'End Date';

  DatePicker _startDatePicker;
  DatePicker _endDatePicker;

  @override
  initState(){
    super.initState();
    AddPrayScreenState state = this.widget;
    _user = state.user;
    _descriptionController.addListener(_onDescriptionChanged);
  }

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    _startDatePicker = DatePicker(value: _valueStartDate,
        onPressed: _startDatePicked);
    _endDatePicker = DatePicker(value: _valueEndDate,
        onPressed: _endDatePicked);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add your pray'),
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

    _pray.idUser = _user.idUser;

    int response = await PrayHttp().postPray(_pray, _user.token);
    if(response == 201){
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