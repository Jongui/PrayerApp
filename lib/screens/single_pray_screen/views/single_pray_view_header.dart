import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prayer_app/components/inputs/rate_bar.dart';
import 'package:prayer_app/localizations.dart';
import 'package:prayer_app/model/pray.dart';
import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/model/user_pray.dart';
import 'package:prayer_app/utils/pray_firebase.dart';

class SinglePrayViewHeader extends StatelessWidget {

  Pray pray;
  User user;
  UserPray userPray;
  String token;
  bool reload = false;

  SinglePrayViewHeader(
      {@required this.pray, @required this.user, @required this.userPray,
        @required this.token, this.reload});

  @override
  Widget build(BuildContext context) {
    return SinglePrayViewHeaderState(pray, user, userPray, token, reload);
  }

}

class SinglePrayViewHeaderState extends StatefulWidget{
  Pray pray;
  User user;
  UserPray userPray;
  String token;
  bool reload;

  SinglePrayViewHeaderState(this.pray, this.user, this.userPray, this.token, this.reload);

  _SinglePrayViewHeaderState createState() => _SinglePrayViewHeaderState(pray, user, userPray, token);

}

class _SinglePrayViewHeaderState extends State<SinglePrayViewHeaderState>{

  Pray pray;
  User user;
  UserPray userPray;
  String token;
  RateBar rateBar;

  ImageProvider _profileImageProvider;

  _SinglePrayViewHeaderState(this.pray, this.user, this.userPray, this.token);

  @override
  void initState() {
    _profileImageProvider = AssetImage("assets/pray.jpg");
    rateBar = RateBar(rateInput: userPray.rate,
      onStarPressed: (rateInput) {
        userPray.rate = rateInput;
      });
    uploadFirebasePrayProfileImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(this.widget.reload){
      uploadFirebasePrayProfileImage();
    }
    this.widget.reload = !this.widget.reload;
    return  Container(
      height: 220.0,
      decoration: BoxDecoration(
          image: DecorationImage(image: _profileImageProvider,
              fit: BoxFit.cover)
      ),
      child: Column(
        children: <Widget>[
          Divider(),
          _buildDetails(context),
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

  void uploadFirebasePrayProfileImage() async{
    StorageReference ref = await PrayFirebase().downloadPrayProfilePicture(this.widget.pray.idPray);
    String _imageUrl = await ref.getDownloadURL();
    setState(() {
      if(_imageUrl != null){
        _profileImageProvider = NetworkImage(_imageUrl);
      }
    });
  }

}