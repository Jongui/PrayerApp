import 'package:flutter/material.dart';
import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/screens/edit_user_screen/edit_user_screen.dart';

class HomeViewHeader extends StatelessWidget {

  String userName;
  String country;
  String avatarUrl;
  String churchName;
  User user;

  Size _screenSize;

  HomeViewHeader(this.userName, this.country, this.avatarUrl, this.churchName, this.user);

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    return _buildProfileHeader(context);
  }

  Widget _buildProfileHeader(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
          color: Colors.white30
      ),
      child: new Column(
        children: <Widget>[
          _buildAvatar(),
          _buildInfos(),
          _buildBarButton(context),
           new Divider()
        ],
      ),
    );
  }

  Widget _buildAvatar(){
    return new Container(
      width: _screenSize.width,
      height: _screenSize.height / 4 / 2,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new CircleAvatar(
            radius: 40.0,
            backgroundColor: Colors.grey,
            backgroundImage: avatarUrl != null ? new NetworkImage(
                avatarUrl) : null,
          ),
        ],
      ),
    );
  }

  Widget _buildInfos(){
    return new Container(
        width: _screenSize.width,
        height: _screenSize.height / 3 / 2,
        child: Stack(
          //alignment: buttonSwingAnimation.value,
          alignment: Alignment.centerLeft,
          children: <Widget>[
            new ListView(
              padding: const EdgeInsets.all(20.0),
              children: <Widget>[
                Text(
                    userName != null ? userName : '',
                    style: new TextStyle( fontWeight: FontWeight.bold,
                                          fontSize: 24.0),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(country != null ? country : '',
                    textAlign: TextAlign.left,
                    style: new TextStyle( fontSize: 20.0),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text( churchName != null ? churchName : '',
                      style: new TextStyle( fontSize: 20.0)
                  ),
                )
              ],
              )
          ]
        )
    );
  }

  Widget _buildBarButton(BuildContext context){
    Container btnEdit = Container(
      height: _screenSize.height / 20,
      width: _screenSize.width / 4,
      margin: EdgeInsets.only(left: 18.0),
      padding: const EdgeInsets.all(0.0),
      decoration: new BoxDecoration(
          border: new Border.all(color: Colors.blueAccent),
          borderRadius: BorderRadius.circular(6.25),
          shape: BoxShape.rectangle
      ),
      child: RaisedButton(
          onPressed: () {
            Navigator.of(context).push(
              new MaterialPageRoute(
                  builder: (context) => new EditUserScreen(user)
              )
            );
            },
          elevation: 0.0,
          color: Colors.white30,
          disabledColor: Colors.blueGrey,
          splashColor: Colors.blue,
          child: Text('Edit'))
    );
    return Row(
      children: <Widget>[
        btnEdit,
      ],
    );
  }

}