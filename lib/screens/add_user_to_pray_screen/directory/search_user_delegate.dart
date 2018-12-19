import 'package:flutter/material.dart';
import 'package:prayer_app/components/buttons/save_button.dart';
import 'package:prayer_app/components/cardviews/user_card_view.dart';
import 'package:prayer_app/localizations.dart';
import 'package:prayer_app/model/user.dart';

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
    Iterable<User> _displaySuggestions = [];
    if(this.query.isEmpty){
      _displaySuggestions = users;
    } else {
      _displaySuggestions = users.where((user) => user.userName.startsWith(query));
    }
    return _SuggestionList(
      query: this.query,
      suggestions: _displaySuggestions.toList(),
      onSelected: (User user){
        this.query = user.userName;
        selectedUser = user;
        showResults(context);
        },
    );
  }

}

class _SuggestionList extends StatelessWidget {
  final List<User> suggestions;
  final String query;
  final ValueChanged<User> onSelected;

  _SuggestionList({this.suggestions, this.query, this.onSelected});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (BuildContext context, int i){
          final User user = suggestions[i];
          return ListTile(
            title: UserCardView(user: user,),
            onTap: () {
              onSelected(user);
            },
          );
        }
    );
  }
}