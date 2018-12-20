import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prayer_app/components/inputs/rate_bar.dart';
import 'package:prayer_app/localizations.dart';
import 'package:prayer_app/model/pray.dart';
import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/model/user_pray.dart';
import 'package:prayer_app/utils/user_pray_http.dart';

class SinglePrayViewHeader extends StatelessWidget {

  Pray pray;
  User user;
  UserPray userPray;
  String token;

  SinglePrayViewHeader(
      {@required this.pray, @required this.user, @required this.userPray,
        @required this.token});

  @override
  Widget build(BuildContext context) {
    return SinglePrayViewHeaderState(pray, user, userPray, token);
  }

}

class SinglePrayViewHeaderState extends StatefulWidget{
  Pray pray;
  User user;
  UserPray userPray;
  String token;

  SinglePrayViewHeaderState(this.pray, this.user, this.userPray, this.token);

  _SinglePrayViewHeaderState createState() => _SinglePrayViewHeaderState(pray, user, userPray, token);

}

class _SinglePrayViewHeaderState extends State<SinglePrayViewHeaderState>{

  Pray pray;
  User user;
  UserPray userPray;
  String token;
  RateBar rateBar;

  _SinglePrayViewHeaderState(this.pray, this.user, this.userPray, this.token);

  @override
  void dispose() {
    UserPrayHttp().putUserPray(userPray, token);
    super.dispose();
  }

  @override
  void initState() {
    rateBar = RateBar(rateInput: userPray.rate,
      onStarPressed: (rateInput) {
        userPray.rate = rateInput;
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 220.0,
      decoration: new BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/pray.jpg"),
              fit: BoxFit.cover)
      ),
      child: Column(
        children: <Widget>[
          _buildDetails(context),
          Divider(),
          _buildRateBar()
        ],
      ),
    );
  }

  Widget _buildDetails(BuildContext context){
    var formatterTo = new DateFormat('dd-MM-yyyy');
    String _subtitle = AppLocalizations.of(context).prayFromTo(formatterTo.format(pray.beginDate),
          formatterTo.format(pray.endDate));
    return Container(
      padding: EdgeInsets.only(top: 76.0),
      child: ListTile(
        title: Text(pray.description,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),),
        subtitle: Text(_subtitle,
            style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,),
        ),
      ),
    );
  }

  Widget _buildRateBar() {

    return rateBar;
  }

}