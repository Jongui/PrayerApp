import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prayer_app/components/dialogs/ok_dialog.dart';
import 'package:prayer_app/components/inputs/date_picker.dart';
import 'package:prayer_app/components/inputs/input_field_area.dart';
import 'package:prayer_app/components/buttons/save_button.dart';
import 'package:prayer_app/localizations.dart';
import 'package:prayer_app/model/pray.dart';
import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/utils/firebase_messaging_utils.dart';
import 'package:prayer_app/utils/pray_http.dart';
import 'package:prayer_app/utils/user_pray_http.dart';

class AddPrayScreen extends StatefulWidget {

  final User user;

  AddPrayScreen({@required this.user});

  @override
  _AddPrayScreenState createState() => new _AddPrayScreenState();

}

class _AddPrayScreenState extends State<AddPrayScreen>{
  TextEditingController _descriptionController = new TextEditingController();

  String _newDescription = '';
  String _newStartDate = '';
  String _newEndDate = '';
  Size _screenSize;
  Pray _pray = Pray();
  String _valueStartDate;
  String _valueEndDate;
  DatePicker _startDatePicker;
  DatePicker _endDatePicker;
  final _formKey = GlobalKey<FormState>();

  _AddPrayScreenState();

  @override
  initState(){
    super.initState();
    _descriptionController.addListener(_onDescriptionChanged);
  }

  @override
  Widget build(BuildContext context) {
    if(_valueStartDate == null){
      _valueStartDate = AppLocalizations.of(context).startDate;
    }
    if(_valueEndDate == null){
      _valueEndDate = AppLocalizations.of(context).endDate;
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
              key: _formKey,
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
        validator: (value){
          if (value.isEmpty) {
            return AppLocalizations().enterSomeText;
          }
          if (value.length > 45) {
            return AppLocalizations().only45Characters;
          }
        },
        hint: AppLocalizations.of(context).description,
        obscure: false,
        controller: _descriptionController,
        labelText: AppLocalizations.of(context).description + ':',
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
    if(_newDescription == '' || _newStartDate == '' || _newDescription == '')
      return;
    if(!_formKey.currentState.validate()){
      return;
    }
    var formatterFrom = new DateFormat('dd/MM/yyyy');
    if(_newDescription != '')
      _pray.description = _newDescription;
    if(_newStartDate != '')
      _pray.beginDate = formatterFrom.parse(_newStartDate);
    if(_newEndDate != '')
      _pray.endDate = formatterFrom.parse(_newEndDate);

    _pray.idUser = this.widget.user.idUser;

    _pray = await PrayHttp().postPray(_pray, this.widget.user.token);
    int response = 0;
    if(_pray != null) {
//      var jsonVar = json.decode(response.body);
//      _pray = Pray.fromJson(jsonVar);
      response =
      await UserPrayHttp().postUserPray(this.widget.user, _pray, _pray.beginDate, _pray.endDate,
          this.widget.user.token);
      FirebaseMessagingUtils().subscribeToPrayTopic(_pray.idPray);
    }
    if(response == 200 || response == 201){
      _pray = Pray();
      await showDialog<String>(
          context: context,
          builder: (BuildContext context) => OkDialog(
            text: AppLocalizations.of(context).prayCreated,
            backgroundColor: Colors.green,
            icon: Icons.check,
          )
      );
    } else {
      await showDialog<String>(
          context: context,
          builder: (BuildContext context) => OkDialog(
            text: AppLocalizations.of(context).errorWhileSaving,
            backgroundColor: Colors.red,
            icon: Icons.error,
          )
      );
    }
    setState(() {

    });
  }
}