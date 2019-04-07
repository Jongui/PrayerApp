import 'package:flutter/material.dart';
import 'package:prayer_app/model/church.dart';
import 'package:prayer_app/localizations.dart';

class ChurchDropdownButton extends StatelessWidget {

  Church selectedChurch;
  final ValueChanged<Church> onChanged;
  List<Church> churches = [];

  ChurchDropdownButton(this.selectedChurch, { @required this.onChanged, @required this.churches});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
        child: DropdownButton<Church>(
          value: selectedChurch,
          hint: Text(AppLocalizations.of(context).churches,),
          onChanged: onChanged,
          items: churches.map<DropdownMenuItem<Church>>((Church church) {
            return DropdownMenuItem<Church>(
              value: church,
              child: Container(
                width: size.width - 75,
                child: Container(
                  padding: EdgeInsets.only(left: 32.0),
                  child: Text(church.name,
                      style: TextStyle(color: Colors.blue, fontSize: 18.0)),
                ),
              )
            );
          }
          ).toList(),
        )
    );
  }

}