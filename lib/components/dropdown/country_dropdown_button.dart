import 'package:flutter/material.dart';
import 'package:prayer_app/components/views/country_flag_view.dart';
import 'package:prayer_app/resources/country_codes.dart';

class CountryDropdownButton<String> extends StatelessWidget {

  String selectedCountry;
  final ValueChanged<String> onChanged;

  CountryDropdownButton(this.selectedCountry, { @required this.onChanged});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(size.width);
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
        child: DropdownButton<String>(
          value: selectedCountry,
          hint: Text("Select"),
          onChanged: onChanged,
          items: countryCodes.map<DropdownMenuItem<String>>((Map value) {
            return DropdownMenuItem<String>(
              value: value["code"],
              child: Container(
                width: size.width - 75,
                child: CountyFlagView(value["code"],
                  width: 36.0,
                  height: 36.0,
                  color: Colors.blue,),
              )
            );
          }
          ).toList(),
        )
    );
  }

}