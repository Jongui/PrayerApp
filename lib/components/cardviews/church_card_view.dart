import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prayer_app/components/views/country_flag_view.dart';
import 'package:prayer_app/model/church.dart';
import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/screens/single_church_screen/single_church_screen.dart';
import 'package:prayer_app/utils/church_firebase.dart';

class ChurchCardView extends StatelessWidget {

  Church church;
  User user;

  ChurchCardView({@required this.church, @required this.user});

  @override
  Widget build(BuildContext context) {
    return ChurchCardViewState(church, user);
  }

}

class ChurchCardViewState extends StatefulWidget{
  Church church;
  User user;

  ChurchCardViewState(this.church, this.user);

  _ChurchCardViewState createState() => _ChurchCardViewState();

}

class _ChurchCardViewState extends State<ChurchCardViewState>{

  ImageProvider _profileImageProvider;

  @override
  void initState() {
    _profileImageProvider = AssetImage("assets/church_background.jpg");
    uploadFirebaseChurchProfileImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(
              new MaterialPageRoute(
                  builder: (context) => SingleChurchScreen(church: this.widget.church,
                    user: this.widget.user,)
              )
          ).whenComplete(onReload);;
        },
        child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: buildCardComponents(context),
            )
        )
    );
  }

  List<Widget> buildCardComponents(BuildContext context){
    List<Widget> ret = [];
    ret.add(Container(
      height: 192.0,
      decoration: new BoxDecoration(
          image: DecorationImage(image: _profileImageProvider,
              fit: BoxFit.cover)
      ),
    )
    );
    ret.add(
        Container(
          color: Colors.grey[100],
          child: ListTile(
            title: Text(this.widget.church.name,
              style: TextStyle(color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
            ),
            subtitle: CountyFlagView(country: this.widget.church.country,
              width: 36.0,
              height: 36.0,),
          ),
        )
    );
    return ret;
  }

  void uploadFirebaseChurchProfileImage() async {
    StorageReference ref = await ChurchFirebase().downloadChurchProfilePicture(this.widget.church.idChurch);
    String _imageUrl = await ref.getDownloadURL();
    setState(() {
      if(_imageUrl != null){
        _profileImageProvider = NetworkImage(_imageUrl);
      }
    });
  }

  onReload() {
    uploadFirebaseChurchProfileImage();
  }

}
