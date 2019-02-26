import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {

  String value;
  ValueChanged<String> onPressed;

  DatePicker({this.value, @required this.onPressed});

  @override
  _DatePickerState createState() => new _DatePickerState();

}

class _DatePickerState extends State<DatePicker>{

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
          border: new Border(
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
          shape: BoxShape.rectangle
      ),
      child: FlatButton(
          onPressed: _selectDate,
          child: new Text(this.widget.value != null ? this.widget.value : "Enter Date")
      ),
    );
  }

  Future _selectDate() async {
    var formatterTo = new DateFormat('dd/MM/yyyy');
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: formatterTo.parse(this.widget.value),
        firstDate: DateTime(2018),
        lastDate: DateTime(2030)
    );
    if(picked != null) setState(() {
      String _value = picked.toString();
      var formatterFrom = new DateFormat('yyyy-MM-dd');
      DateTime dateTime = formatterFrom.parse(_value);
      _value = formatterTo.format(dateTime);
      this.widget.onPressed(_value);
    });
  }

}