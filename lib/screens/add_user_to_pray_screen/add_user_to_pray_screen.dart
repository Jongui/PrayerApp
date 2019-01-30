import 'package:flutter/material.dart';
import 'package:prayer_app/components/cardviews/user_card_view.dart';
import 'package:prayer_app/localizations.dart';
import 'package:prayer_app/model/pray.dart';
import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/screens/add_user_to_pray_screen/delegates/search_user_delegate.dart';
import 'package:prayer_app/utils/firebase_messaging_utils.dart';

class AddUserToPrayScreen extends StatelessWidget {

  List<User> users;
  Pray pray;
  String token;

  AddUserToPrayScreen(
      {@required this.users, @required this.pray, @required this.token});

  @override
  Widget build(BuildContext context) {
    return AddUserToPrayScreenState(users, pray, token);
  }

}

class AddUserToPrayScreenState extends StatefulWidget{
  List<User> users;
  Pray pray;
  String token;
  AddUserToPrayScreenState(this.users, this.pray, this.token);

  _AddUserToPrayScreenState createState() => _AddUserToPrayScreenState(users, pray, token);

}

class _AddUserToPrayScreenState extends State<AddUserToPrayScreenState>{
  List<User> users;
  Pray pray;
  String token;
  SearchUserDelegate _delegate;
  _AddUserToPrayScreenState(this.users, this.pray, this.token);

  @override
  void initState() {
    _delegate = SearchUserDelegate(users: users);
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
              _sendFirebaseMessage(_user);
            },
          ),
        ],
      ),
      body: Scrollbar(
          child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, idx) => ListTile(
                title: UserCardView(user: users[idx],),
                onTap: () async {
                  User _user = users[idx];
                  _sendFirebaseMessage(_user);
                  Navigator.pop(context, true);
                },
              )
          )
      ),
    );
  }

  void _sendFirebaseMessage(User user) async{
    if(user != null){
      String _churchName = pray.description;
      String _message =
          'You were invited to pray $_churchName. Confirm?';
      FirebaseMessagingUtils().sendToUserTopic(
          user.idUser,
          'Pray membership invitation',
          _message,
          _buildDataPayload(FirebaseMessagingUtils.ADD_USER_TO_PRAY,
              pray.idPray));
      Navigator.pop(context, true);
    }
  }

  Map<String, dynamic> _buildDataPayload(int action, int idPray) =>
      {'action': action, 'idPray': idPray};

}