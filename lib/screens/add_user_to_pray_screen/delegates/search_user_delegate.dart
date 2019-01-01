import 'package:flutter/material.dart';
import 'package:prayer_app/components/buttons/save_button.dart';
import 'package:prayer_app/components/cardviews/user_card_view.dart';
import 'package:prayer_app/localizations.dart';
import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/utils/user_http.dart';

class SearchUserDelegate extends SearchDelegate<String>{

  List<User> users;
  User selectedUser;

  SearchUserDelegate({@required this.users});

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      query.isNotEmpty
        ? IconButton(
        tooltip: 'Clear',
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        }
      )
          : IconButton(
        icon: Icon(Icons.search),
        onPressed: () {

        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {

      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10.0),
              child: CircleAvatar(
                radius: 60.0,
                backgroundColor: Colors.grey,
                backgroundImage: this.selectedUser.avatarUrl != null ? new NetworkImage(
                    this.selectedUser.avatarUrl) : null,
              ),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              child: Text(
                AppLocalizations.of(context).confirmAddingUserToPray(this.selectedUser.userName),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.italic
                ),
              ),
            ),
            SaveButton(
              onPressed: () {
                  this.close(context, this.selectedUser.userName);
              }
              ),
          ]
        )
      )
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _SuggestionList(
      query: this.query,
      onSelected: (User user){
        this.query = user.userName;
        selectedUser = user;
        showResults(context);
        },
    );
  }

}

class _SuggestionList extends StatelessWidget {
  final String query;
  final ValueChanged<User> onSelected;
  final String token;

  _SuggestionList({this.query, this.onSelected, this.token});

  @override
  Widget build(BuildContext context) {
    return _SuggestionListState(query, onSelected, token);
  }
}

class _SuggestionListState extends StatefulWidget {
  String query;
  ValueChanged<User> onSelected;
  String token;

  _SuggestionListState(this.query, this.onSelected, this.token);

  _SuggestionListStateCont createState() => _SuggestionListStateCont();
}

class _SuggestionListStateCont extends State<_SuggestionListState> {
  Widget _view;
  String _oldQuery;

  @override
  void initState() {
    _oldQuery = '';
    //_handleLoadingUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(_view == null){
      _view = Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
              child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
                Container(
                  margin: EdgeInsets.all(10.0),
                  child: Text(
                    AppLocalizations.of(context).searchUser,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.normal,
                        fontStyle: FontStyle.italic),
                  ),
                ),
              ])));
    }
    if (_oldQuery != this.widget.query
        && this.widget.query.length >= 3) {
      _handleLoadingUsers();
      _oldQuery = this.widget.query;
    }
    return _view;
  }

  void _handleLoadingUsers() async {
    List<User> _users =
    await UserHttp().getUsersByUserName(this.widget.query, this.widget.token);
    setState(() {
      _view = ListView.builder(
          itemCount: _users.length,
          itemBuilder: (BuildContext context, int i) {
            final User user = _users[i];
            return ListTile(
              title: UserCardView(
                user: user,
              ),
              onTap: () {
                this.widget.onSelected(user);
              },
            );
          });
    });
  }
}