import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatelessWidget {

  String value;
  ValueChanged<String> onPressed;

  DatePicker({this.value, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return DatePickerState(value: value, onPressed: onPressed,);
  }

}

class DatePickerState extends StatefulWidget {

  String value;
  ValueChanged<String> onPressed;

  DatePickerState({Key key, this.value, this.onPressed}) : super(key: key);

  @override
  _DatePickerState createState() => new _DatePickerState();

}

class _DatePickerState extends State<DatePickerState>{

  String _value;

  @override
  void initState() {
    DatePickerState state = this.widget;
    _value = state.value;
    super.initState();
  }

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
          child: new Text(_value != null ? _value : "Enter Date")
      ),
    );
  }

  Future _selectDate() async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2016),
        lastDate: new DateTime(2019)
    );
    if(picked != null) setState(() {
      _value = picked.toString();
      var formatterFrom = new DateFormat('yyyy-MM-dd');
      DateTime dateTime = formatterFrom.parse(_value);
      var formatterTo = new DateFormat('dd/MM/yyyy');
      _value = formatterTo.format(dateTime);
      this.widget.onPressed(_value);
    });
  }

}