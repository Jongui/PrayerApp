import 'package:flutter/material.dart';
import 'package:prayer_app/localizations.dart';
import 'package:prayer_app/model/pray.dart';
import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/utils/firebase_messaging_utils.dart';
import 'package:prayer_app/utils/user_firebase.dart';
import 'package:prayer_app/utils/user_pray_http.dart';

class ConfirmPrayMembershipDialog extends StatelessWidget {
  final Pray pray;
  final User user;
  final String token;

  ConfirmPrayMembershipDialog(
      {@required this.pray, @required this.user, @required String this.token});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
          AppLocalizations.of(context).confirmPrayMembership(pray.description)),
      actions: <Widget>[
        FlatButton(
          child: Text(AppLocalizations.of(context).confirm),
          onPressed: () async {
            await UserPrayHttp()
                .postUserPray(user, pray, DateTime.now(), pray.endDate, token);
            FirebaseMessagingUtils().subscribeToPrayTopic(pray.idPray);
            UserFirebase().deletePrayInvitation(user.idUser, pray.idPray);
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Text(AppLocalizations.of(context).cancel),
          onPressed: () {
            UserFirebase().deletePrayInvitation(user.idUser, pray.idPray);
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
