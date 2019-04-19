import 'package:flutter/material.dart';
import 'package:prayer_app/components/dialogs/ok_dialog.dart';
import 'package:prayer_app/components/dropdown/country_dropdown_button.dart';
import 'package:prayer_app/components/inputs/input_field_area.dart';
import 'package:prayer_app/components/buttons/save_button.dart';
import 'package:prayer_app/localizations.dart';
import 'package:prayer_app/model/church.dart';
import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/utils/church_http.dart';

class AddChurchScreen extends StatefulWidget {
  User user;

  AddChurchScreen({@required this.user});

  @override
  _AddChurchScreenState createState() => new _AddChurchScreenState();
}

class _AddChurchScreenState extends State<AddChurchScreen> {
  TextEditingController _churchNameController = new TextEditingController();
  TextEditingController _cityController = new TextEditingController();

  String _newChurchName = '';
  Size _screenSize;
  String _newCountry = '';
  String _newCity = '';
  Church _church = Church();
  String _language;
  final _formKey = GlobalKey<FormState>();

  @override
  initState() {
    super.initState();
    _churchNameController.addListener(_onChurchNameChanged);
    _cityController.addListener(_onCityChanged);
  }

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).title),
      ),
      body: Builder(builder: (context) => _buildInputForm(context)),
    );
  }

  void _onChurchNameChanged() {
    _newChurchName = _churchNameController.text;
  }

  void _onCityChanged() {
    _newCity = _cityController.text;
  }

  Widget _buildInputForm(BuildContext context) {
    if (_newCountry == '') _newCountry = 'BR';
    Locale locale = Localizations.localeOf(context);
    _language = locale.languageCode;
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

  Widget _buildChurchNameInputField() {
    return Container(
      padding:
          EdgeInsets.only(left: 24.0, right: 24.0, top: 12.0, bottom: 10.0),
      child: InputFieldArea(
        validator: (value) {
          if (value.length > 45) {
            return AppLocalizations().only45Characters;
          }
        },
        hint: AppLocalizations.of(context).name,
        obscure: false,
        controller: _churchNameController,
        labelText: AppLocalizations.of(context).churchName + ':',
      ),
    );
  }

  Widget _buildCityInputField() {
    return Container(
        padding:
            EdgeInsets.only(left: 24.0, right: 24.0, top: 12.0, bottom: 10.0),
        child: InputFieldArea(
          validator: (value) {
            if (value.length > 45) {
              return AppLocalizations().only45Characters;
            }
          },
          hint: AppLocalizations.of(context).city,
          obscure: false,
          controller: _cityController,
          labelText: AppLocalizations.of(context).city + ':',
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
    if (_newChurchName == '' || _newCountry == '' || _newCity == '') return;
    if (!_formKey.currentState.validate()) {
      return;
    }
    if (_newChurchName != '') _church.name = _newChurchName;
    if (_newCountry != '') _church.country = _newCountry;
    if (_newCity != '') _church.city = _newCity;
    _church.region = AppLocalizations.of(context).notInformed;
    _church.createdBy = this.widget.user.idUser;
    _church.createdAt = DateTime.now();
    int response =
        await ChurchHttp().postChurch(_church, this.widget.user.token);
    if (response == 201) {
      _church = Church();
      showDialog<String>(
          context: context,
          builder: (BuildContext context) => OkDialog(
                text: AppLocalizations.of(context).churchCreated,
                backgroundColor: Colors.green,
                icon: Icons.check,
              ));
    } else {
      showDialog<String>(
          context: context,
          builder: (BuildContext context) => OkDialog(
                text: AppLocalizations.of(context).errorWhileSaving,
                backgroundColor: Colors.red,
                icon: Icons.error,
              ));
    }
    setState((){

    });
  }

  Widget _buildCountryDropDownButton() {
    return Container(
      height: 120.0,
      padding:
          EdgeInsets.only(left: 24.0, right: 24.0, top: 12.0, bottom: 10.0),
      child: CountryDropdownButton(
        _newCountry,
        languageLowerCase: _language.toLowerCase(),
        onChanged: (newCountry) {
          setState(() {
            _newCountry = newCountry.code;
          });
        },
      ),
    );
  }
}
