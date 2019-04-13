import 'package:flutter/material.dart';

class OkDialog extends StatelessWidget {
  String text;
  Color backgroundColor;
  IconData icon;

  OkDialog({@required this.text, @required this.backgroundColor, @required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
        contentPadding: EdgeInsets.only(top: 10.0),
        content: Container(
              padding: EdgeInsets.only(top: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    icon,
                    color: backgroundColor,
                    size: 50.0,
                  ),
                  Flexible(
                      fit: FlexFit.loose,
                      child: Container(
                          margin: EdgeInsets.only(top: 10.0),
                          child: Text(
                            this.text,
                            softWrap: true,
                            overflow: TextOverflow.clip,
                            style: TextStyle(fontSize: 20.0),
                          )))
                ],
              ),
            ),
        actions: <Widget>[
          ButtonTheme(
            child: ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: Text(
                    'OK',
                    style: TextStyle(color: Colors.lightBlueAccent),
                  ),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
