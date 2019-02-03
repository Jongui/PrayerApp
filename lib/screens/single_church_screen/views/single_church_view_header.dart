import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prayer_app/model/church.dart';
import 'package:prayer_app/localizations.dart';
import 'package:prayer_app/utils/church_firebase.dart';

class SingleChurchViewHeader extends StatelessWidget{

  Church church;
  bool reload = false;

  SingleChurchViewHeader({@required this.church, this.reload});

  @override
  Widget build(BuildContext context) {
    return SingleChurchViewHeaderState(church, this.reload);
  }

}

class SingleChurchViewHeaderState extends StatefulWidget{
  Church church;
  bool reload;

  SingleChurchViewHeaderState(this.church, this.reload);

  _SingleChurchViewHeaderState createState() => _SingleChurchViewHeaderState();

}

class _SingleChurchViewHeaderState extends State<SingleChurchViewHeaderState>{

  ImageProvider _profileImageProvider;

  @override
  void initState() {
    _profileImageProvider = AssetImage("assets/church_background.jpg");
    downloadFirebaseChurchProfileImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(this.widget.reload){
      downloadFirebaseChurchProfileImage();
    }
    this.widget.reload = !this.widget.reload;
    return Container(
      height: 180.0,
      decoration: new BoxDecoration(
          image: DecorationImage(image: _profileImageProvider,
              fit: BoxFit.cover)
      ),
      child: new Column(
        children: <Widget>[
          _buildDetails(context),
          new Divider()
        ],
      ),
    );
  }

  Widget _buildDetails(BuildContext context){
    var formatterTo = DateFormat('dd-MM-yyyy');
    String _subtitle = AppLocalizations.of(context).createdAt(formatterTo.format(this.widget.church.createdAt));
    return Container(
      padding: EdgeInsets.only(top: 76.0),
      child: ListTile(
        title: Text(this.widget.church.name,
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

  void downloadFirebaseChurchProfileImage() async {
    StorageReference ref = await ChurchFirebase().downloadChurchProfilePicture(this.widget.church.idChurch);
    if(ref == null){
      return;
    }
    try {
      String _imageUrl = await ref.getDownloadURL();
      setState(() {
        if (_imageUrl != null) {
          _profileImageProvider = NetworkImage(_imageUrl);
        }
      });
    }catch(e){

    }
  }


}
