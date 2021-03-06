import 'package:flutter/material.dart';
import 'package:prayer_app/components/cardviews/user_card_view.dart';
import 'package:prayer_app/localizations.dart';
import 'package:prayer_app/model/church.dart';
import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/screens/add_user_to_church_screen/delegates/search_user_delegate.dart';
import 'package:prayer_app/utils/firebase_messaging_utils.dart';
import 'package:prayer_app/utils/user_firebase.dart';

class AddUserToChurchScreen extends StatelessWidget {
  List<User> users;
  Church church;
  String token;

  AddUserToChurchScreen(
      {@required this.users, @required this.church, @required this.token});

  @override
  Widget build(BuildContext context) {
    return AddUserToChurchScreenState(users, church, token);
  }
}

class AddUserToChurchScreenState extends StatefulWidget {
  List<User> users;
  Church church;
  String token;
  AddUserToChurchScreenState(this.users, this.church, this.token);

  _AddUserToChurchScreenState createState() =>
      _AddUserToChurchScreenState(users, church, token);
}

class _AddUserToChurchScreenState extends State<AddUserToChurchScreenState> {
  List<User> users;
  Church church;
  String token;

  _AddUserToChurchScreenState(this.users, this.church, this.token);

  SearchUserDelegate _delegate;

  @override
  void initState() {
    _delegate =
        SearchUserDelegate(users: users, church: church, token: token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(AppLocalizations.of(context).editUser),
        actions: <Widget>[
          IconButton(
            tooltip: 'Search',
            icon: const Icon(Icons.search),
            onPressed: () async {
              await showSearch<String>(
                context: context,
                delegate: _delegate,
              );
              User _user = _delegate.selectedUser;
              if (_user != null) {
                _sendFirebaseMessage(_user);
                UserFirebase().saveChurchInvitation(_user.idUser, church.idChurch);
                Navigator.pop(context, true);
              }
            },
          ),
        ],
      ),
      body: Scrollbar(
          child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, idx) => ListTile(
                    title: UserCardView(
                      user: users[idx],
                    ),
                    onTap: () async {
                      User _user = users[idx];
                      UserFirebase().saveChurchInvitation(_user.idUser, church.idChurch);
                      _sendFirebaseMessage(_user);
                      Navigator.pop(context, true);
                    },
                  ))),
    );
  }

  void _sendFirebaseMessage(User user) {
    String _churchName = church.name;
    FirebaseMessagingUtils().sendToUserTopic(
        user.idUser,
        AppLocalizations.of(context).churchMembershipInvitation,
        AppLocalizations.of(context).churchInvitationMessage(_churchName),
        FirebaseMessagingUtils.CHURCH_NOTIFICATION);
  }
}
