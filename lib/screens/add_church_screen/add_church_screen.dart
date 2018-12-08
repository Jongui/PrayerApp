import 'package:flutter/material.dart';
import 'package:prayer_app/components/dropdown/country_dropdown_button.dart';
import 'package:prayer_app/components/inputs/input_field_area.dart';
import 'package:prayer_app/components/buttons/save_button.dart';
import 'package:prayer_app/model/church.dart';
import 'package:prayer_app/utils/church_http.dart';

class AddChurchScreen extends StatelessWidget {

  String token;

  AddChurchScreen({@required this.token});

  @override
  Widget build(BuildContext context) {
    return AddChurchScreenState(
      token: token,);
  }

}

class AddChurchScreenState extends StatefulWidget {

  AddChurchScreenState({Key key, this.token}) : super(key: key);

  final String token;

  @override
  _AddChurchScreenState createState() => new _AddChurchScreenState();

}

class _AddChurchScreenState extends State<AddChurchScreenState>{
  TextEditingController _churchNameController = new TextEditingController();
  TextEditingController _cityController = new TextEditingController();

  String _newChurchName = '';
  Size _screenSize;
  String _newCountry = '';
  String _newCity = '';
  Church _church = Church();
  String _token;

  @override
  initState(){
    super.initState();
    _churchNameController.addListener(_onChurchNameChanged);
    _cityController.addListener(_onCityChanged);
  }

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Prays App'),
      ),
      body: Builder(builder: (context) => _buildInputForm(context)),
    );

  }

  void _onChurchNameChanged(){
    _newChurchName = _churchNameController.text;
  }

  void _onCityChanged(){
    _newCity = _cityController.text;
  }

  Widget _buildInputForm(BuildContext context){
    AddChurchScreenState state = this.widget;
    _token = state.token;
    if(_newCountry == '')
      _newCountry = 'BR';
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
                  _buildChurchNameInputField(),
                  _buildCityInputField(),
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

  Widget _buildChurchNameInputField(){
    return Container(
      padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 12.0, bottom: 10.0),
      child: InputFieldArea(
        hint: 'Name',
        obscure: false,
        controller: _churchNameController,
        labelText: 'Church Name:',
      ),
    );
  }

  Widget _buildCityInputField(){
    return Container(
        padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 12.0, bottom: 10.0),
        child: InputFieldArea(
          hint: 'City',
          obscure: false,
          controller: _cityController,
          labelText: 'City:',
        )
    );
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
    if(_newChurchName == '' || _newCountry == '' || _newCity == '')
      return;
    if(_newChurchName != '')
      _church.name = _newChurchName;
    if(_newCountry != '')
      _church.country = _newCountry;
    if(_newCity != '')
      _church.city = _newCity;
    _church.region = 'Not informed';
    int response = await ChurchHttp().postChurch(_church, _token);
    if(response == 201){
      final snackBar = SnackBar(
        content: Text('Church created!',
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

  Widget _buildCountryDropDownButton(){
    return Container(
      height: 120.0,
      padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 12.0, bottom: 10.0),
      child: CountryDropdownButton(_newCountry,
        onChanged: (newCountry){
          setState(() {
            _newCountry = newCountry;
          });
        },
      ),
    );
  }

}