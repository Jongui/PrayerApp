import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FloatAddButton extends StatelessWidget {

  final VoidCallback onPressed;

  FloatAddButton({@required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.green,
      onPressed: onPressed,
      tooltip: 'Add new',
      child: Icon(FontAwesomeIcons.plus,
          color: Colors.white,
          size: 32.0
      ),
    );
  }

}