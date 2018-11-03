import 'package:flutter/material.dart';
import 'package:prayer_app/model/user.dart';

class EditUserScreen extends StatelessWidget {

  User user;

  EditUserScreen(this.user);

  @override
  Widget build(BuildContext context) {
    return EditUserScreenState(user: user);
  }

}

class EditUserScreenState extends StatefulWidget {

  EditUserScreenState({Key key, this.user}) : super(key: key);

  final User user;

  @override
  _EditUserScreenState createState() => new _EditUserScreenState();

}

class _EditUserScreenState extends State<EditUserScreenState>{

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Prays App'),
      ),
      body: _buildInputForm(),
    );
  }

  Widget _buildInputForm(){
    Size screenSize = MediaQuery.of(context).size;
    EditUserScreenState state = this.widget;
    return Container(
      width: screenSize.width,
      height: screenSize.height,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Form(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new InputFieldArea(
                    hint: state.user.userName,
                    obscure: false,
                    icon: Icons.person_outline,
                  ),
                  new InputFieldArea(
                    hint: state.user.country,
                    obscure: false,
                  ),
                ],
              )),
        ],
      ),
    );
  }

}

class InputFieldArea extends StatelessWidget {
  final String hint;
  final bool obscure;
  final IconData icon;
  InputFieldArea({this.hint, this.obscure, this.icon});
  @override
  Widget build(BuildContext context) {
    return (new Container(
      decoration: new BoxDecoration(
        border: new Border(
          bottom: new BorderSide(
            width: 0.5,
            color: Colors.blue,
          ),
        ),
      ),
      child: new TextFormField(
        obscureText: obscure,
        style: const TextStyle(
          color: Colors.blue,
        ),
        decoration: new InputDecoration(
          icon: new Icon(
            icon,
            color: Colors.blue,
          ),
          border: InputBorder.none,
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.blue, fontSize: 15.0),
          contentPadding: const EdgeInsets.only(
              top: 30.0, right: 30.0, bottom: 30.0, left: 5.0),
        ),
      ),
    ));
  }
}