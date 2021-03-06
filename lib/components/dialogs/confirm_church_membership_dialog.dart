import 'package:flutter/material.dart';
import 'package:prayer_app/localizations.dart';
import 'package:prayer_app/model/church.dart';
import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/utils/firebase_messaging_utils.dart';
import 'package:prayer_app/utils/user_firebase.dart';
import 'package:prayer_app/utils/user_http.dart';

class ConfirmChurchMembershipDialog extends StatelessWidget{

  final Church church;
  final User user;
  final String token;

  ConfirmChurchMembershipDialog({@required this.church, @required this.user, @required String this.token});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context).confirmChurchMembership(church.name)),
      actions: <Widget>[
        FlatButton(
          child: Text(AppLocalizations.of(context).confirm),
          onPressed:() async {
            FirebaseMessagingUtils().unsubscribeFromChurchTopic(user.church);
            user.church = church.idChurch;
            await UserHttp().putUser(user, token: token);
            FirebaseMessagingUtils().subscribeToChurchTopic(user.church);
            UserFirebase().deleteChurchInvitation(user.idUser);
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Text(AppLocalizations.of(context).cancel),
          onPressed: (){
            UserFirebase().deleteChurchInvitation(user.idUser);
            Navigator.pop(context);
          },
        )
      ],
    );
  }


}