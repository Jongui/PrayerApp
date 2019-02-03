import 'package:flutter/material.dart';
import 'package:prayer_app/components/buttons/float_edit_button.dart';
import 'package:prayer_app/localizations.dart';
import 'package:prayer_app/model/church.dart';
import 'package:prayer_app/model/user.dart';
import 'package:prayer_app/screens/add_user_to_church_screen/add_user_to_church_screen.dart';
import 'package:prayer_app/screens/church_album_screen/church_album_screen.dart';
import 'package:prayer_app/screens/edit_church_screen/edit_church_screen.dart';
import 'package:prayer_app/screens/single_church_screen/views/single_church_view.dart';
import 'package:prayer_app/screens/single_church_screen/views/single_church_view_messages.dart';
import 'package:prayer_app/utils/user_http.dart';

class SingleChurchTabBarView extends StatefulWidget {
  final User user;
  final Church church;
  SingleChurchTabBarView({@required this.user, @required this.church});

  _SingleChurchTabBarViewState createState() => _SingleChurchTabBarViewState();
}

class _SingleChurchTabBarViewState extends State<SingleChurchTabBarView>
    with SingleTickerProviderStateMixin {
  bool _reload = false;
  static int _activeTab = 0;

  TabController _tabController;

  var _tabPages = <Widget>[];
  var _tabButtons;

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
    if (_reload) _reload = !_reload;

    _tabPages = [
      SingleChurchView(
          church: this.widget.church,
          user: this.widget.user,
          reload: _reloadParam),
      SingleChurchViewMessages(
        user: this.widget.user,
        church: this.widget.church,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).viewChurch),
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
                List<User> _users;
                _users = await UserHttp().getAllUsers(this.widget.user.token);
                Navigator.of(context)
                    .push(new MaterialPageRoute(
                        builder: (context) => AddUserToChurchScreen(
                              users: _users,
                              church: this.widget.church,
                              token: this.widget.user.token,
                            )))
                    .whenComplete(onReload);
              },
              onEditPressed: () {
                Navigator.of(context)
                    .push(new MaterialPageRoute(
                        builder: (context) => EditChurchScreen(
                              church: this.widget.church,
                              user: this.widget.user,
                            )))
                    .whenComplete(onReload);
              },
              onAlbumClicked: () {
                Navigator.of(context)
                    .push(new MaterialPageRoute(
                        builder: (context) => ChurchAlbumScreen(
                              church: this.widget.church,
                              token: this.widget.user.token,
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
