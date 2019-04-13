import 'package:flutter/material.dart';
import 'package:prayer_app/components/buttons/float_edit_button.dart';
import 'package:prayer_app/localizations.dart';
import 'package:prayer_app/model/pray.dart';
import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/model/user_pray.dart';
import 'package:prayer_app/screens/add_user_to_pray_screen/add_user_to_pray_screen.dart';
import 'package:prayer_app/screens/edit_pray_screen/edit_pray_screen.dart';
import 'package:prayer_app/screens/pray_album_screen/pray_album_screen.dart';
import 'package:prayer_app/screens/single_pray_screen/views/single_pray_view.dart';
import 'package:prayer_app/screens/single_pray_screen/views/single_pray_view_messages.dart';
import 'package:prayer_app/utils/user_http.dart';

class SinglePrayScreen extends StatefulWidget {
  Pray pray;
  User user;
  UserPray userPray;

  SinglePrayScreen(
      {@required this.pray, @required this.user, @required this.userPray});

  @override
  _SinglePrayScreenState createState() =>
      _SinglePrayScreenState(pray, user, userPray);

}

class _SinglePrayScreenState extends State<SinglePrayScreen>
    with SingleTickerProviderStateMixin {
  Pray pray;
  User user;
  UserPray userPray;
  bool _reload = false;

  static int _activeTab = 0;

  TabController _tabController;

  var _tabPages = <Widget>[];
  var _tabButtons;

  _SinglePrayScreenState(this.pray, this.user, this.userPray);

  @override
  void initState() {
    _tabButtons = <Tab>[
      Tab(
        icon: IconButton(
          icon: Icon(Icons.people, color: Colors.white70),
          onPressed: () {
            _activeTab = 0;
            setState(() {
              _tabController.index = _activeTab;
            });
          },
        ),
      ),
      Tab(
        icon: IconButton(
          icon: Icon(Icons.message, color: Colors.white70),
          onPressed: () {
            _activeTab = 1;
            setState(() {
              _tabController.index = _activeTab;
            });
          },
        ),
      )
    ];
    _tabController = TabController(vsync: this, length: _tabButtons.length);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool _reloadParam = _reload;
    if(_reload)
      _reload = !_reload;

    _tabPages = [
      SinglePrayView(
          pray: pray,
          user: user,
          userPray: userPray,
          token: user.token,
          reload: _reloadParam),
      SinglePrayViewMessages(
        user: this.widget.user,
        pray: this.widget.pray,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).viewPray),
        bottom: TabBar(
          tabs: _tabButtons,
          controller: _tabController,
        ),
      ),

      body: TabBarView(
        children: _tabPages.map((widget) {
          return widget;
        }).toList(),
        controller: _tabController,
      ),
      floatingActionButton: _tabController.index == 0
          ? FloatEditButton(
              onAddPressed: () async {
                List<User> _users = await UserHttp().getAllUsers(user.token);
                Navigator.of(context)
                    .push(new MaterialPageRoute(
                        builder: (context) => AddUserToPrayScreen(
                              users: _users,
                              pray: pray,
                              token: user.token,
                              invitingUser: user,
                            )))
                    .whenComplete(onReload);
              },
              onEditPressed: () {
                Navigator.of(context)
                    .push(new MaterialPageRoute(
                        builder: (context) => EditPrayScreen(
                              pray: pray,
                              token: user.token,
                            )))
                    .whenComplete(onReload);
              },
              onAlbumClicked: () {
                Navigator.of(context)
                    .push(new MaterialPageRoute(
                    builder: (context) => PrayAlbumScreen(
                      pray: pray,
                      token: user.token,
                    )))
                    .whenComplete(onReload);
              },
            )
          : null,
    );
  }

  onReload() {
    setState(() {
      _reload = true;
    });
  }
}
