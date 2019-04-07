import 'package:flutter/material.dart';
import 'package:prayer_app/components/views/country_flag_view.dart';
import 'package:prayer_app/model/country.dart';
import 'package:prayer_app/resources/country_codes.dart';
import 'package:prayer_app/localizations.dart';

class CountryDropdownButton<T> extends StatelessWidget {

  String selectedCountry;
  Country _selectedCountryName;
  final ValueChanged<Country> onChanged;
  List<DropdownMenuItem<Country>> _dropDownList = [];
  Size _size;
  String languageLowerCase;

  CountryDropdownButton(this.selectedCountry, { @required this.onChanged, @required this.languageLowerCase});

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    print(_size.width);
    _buildDropDownList();
    return Container(
        padding: EdgeInsets.only(top: 12.0, bottom: 10.0),
        decoration: BoxDecoration(
            border: Border(
              bottom: new BorderSide(
                width: 0.5,
                color: Colors.blue,
              ),
              top:  new BorderSide(
                width: 0.5,
                color: Colors.blue,
              ),
              left:  new BorderSide(
                width: 0.5,
                color: Colors.blue,
              ),
              right:  new BorderSide(
                width: 0.5,
                color: Colors.blue,
              ),
            ),
            borderRadius: BorderRadius.circular(6.25),
            shape: BoxShape.rectangle,
        ),
        child: DropdownButton<Country>(
          value: _selectedCountryName,
          hint: Text(AppLocalizations.of(context).country),
          onChanged: onChanged,
          items: _dropDownList,
        )
    );
  }

  void _buildDropDownList( ) {
    Map countries = countryCodes[0];
    countries.forEach((code, translations) {
      Country country = Country(code: code, name: translations["translations"][languageLowerCase]);
      if(code == selectedCountry) {
        _selectedCountryName = country;
      }
      _dropDownList.add(
          DropdownMenuItem<Country>(
              value: country,
              child: Container(
                width: _size.width - 75,
                child: CountyFlagView(country: code,
                  width: 36.0,
                  height: 36.0,
                  color: Colors.blue,),
              )
          )
      );
    });
    _dropDownList.sort((a1, a2) {
      return a1.value.name.toString().compareTo(a2.value.name.toString());
    });
  }

}