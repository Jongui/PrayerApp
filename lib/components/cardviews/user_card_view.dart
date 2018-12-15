import 'package:flutter/material.dart';
import 'package:prayer_app/components/views/country_flag_view.dart';
import 'package:prayer_app/model/user.dart';

class UserCardView extends StatelessWidget {

  User user;
  UserCardView({@required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: buildCardComponents(context),
      ),
    );
  }

  List<Widget> buildCardComponents(BuildContext context) {
    List<Widget> ret = [];
    ret.add(Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10.0),
          child: CircleAvatar(
            radius: 20.0,
            backgroundColor: Colors.grey,
            backgroundImage: user.avatarUrl != null ? new NetworkImage(
                user.avatarUrl) : null,
          ),
        ),
        Container(
          width: 300.0,
          margin: EdgeInsets.only(left: 10.0),
          child: ListTile(
              title: Text(user.userName,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),),
              subtitle: CountyFlagView(country: user.country,
                width: 32.0,
                height: 32.0,
                color: Colors.black,))
        )
      ],
    ));
    return ret;
  }

}