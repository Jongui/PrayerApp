import 'package:flutter/material.dart';

class StarIconButton extends StatelessWidget{

  int position;
  Color color;
  ValueChanged<int> onStarPressed;
  StarIconButton({@required this.position, @required this.color,
    @required this.onStarPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.star,
        color: color,),
      onPressed:(){
        this.onStarPressed(position);
      },
    );
  }
}