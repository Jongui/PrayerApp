import 'package:flutter/material.dart';
import 'package:prayer_app/components/views/country_flag_view.dart';
import 'package:prayer_app/components/buttons/edit_button.dart';
import 'package:prayer_app/model/church.dart';
import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/screens/edit_user_screen/edit_user_screen.dart';
import 'package:prayer_app/screens/loading_screen/loading_view.dart';
import 'package:prayer_app/utils/church_http.dart';

class HomeViewHeader extends StatelessWidget {

  User user;


  HomeViewHeader(this.user);

  @override
  Widget build(BuildContext context) {
    return HomeViewHeaderState(user);
  }
}

class HomeViewHeaderState extends StatefulWidget {

  User user;

  HomeViewHeaderState(this.user);

  @override
  _HomeViewHeaderState createState() => _HomeViewHeaderState(user);


}

class _HomeViewHeaderState extends State<HomeViewHeaderState>{

  Size _screenSize;
  Church _church;

  User user;

  _HomeViewHeaderState(this.user);


  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    if(_church == null || _church.idChurch != user.church){
      _handleChurchLoad(user.church, this.user.token);
    }
    return Container(
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
            backgroundImage: user.avatarUrl != null ? new NetworkImage(
                user.avatarUrl) : null,
          ),
        ],
      ),
    );
  }

  Widget _buildInfos(){
    if(_church != null){
      return Container(
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
                      user.userName != null ? user.userName : '',
                      style: new TextStyle( fontWeight: FontWeight.bold,
                          fontSize: 24.0),
                    ),
                    CountyFlagView(user.country,
                      width: 36.0,
                      height: 36.0,),
                    Container(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text( _church.name != null ? _church.name : '',
                          style: new TextStyle( fontSize: 20.0)
                      ),
                    )
                  ],
                )
              ]
          )
      );
    } else {
      return LoadingView();
    }

  }

  Widget _buildBarButton(BuildContext context){
    return Row(
      children: <Widget>[
        EditButton(
          onPressed: () {
            Navigator.of(context).push(
                new MaterialPageRoute(
                    builder: (context) => new EditUserScreen(user)
                ));
          },
          screenSize: _screenSize,
        )
      ],
    );
  }

  void _handleChurchLoad(int idChurch, String token) async{
    Church church = await ChurchHttp().fetchChurch(idChurch, token);
    setState(() {
      _church = church;
    });
  }

}