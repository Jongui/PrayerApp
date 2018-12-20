import 'package:flutter/material.dart';
import 'package:prayer_app/components/buttons/star_icon_button.dart';

class RateBar extends StatelessWidget {
  int rateInput;
  ValueChanged<int> onStarPressed;

  RateBar({@required this.rateInput, @required this.onStarPressed});

  @override
  Widget build(BuildContext context) {
    return RateBarState(rateInput, onStarPressed);
  }
}

class RateBarState extends StatefulWidget {
  int rateInput;
  ValueChanged<int> onStarPressed;
  RateBarState(this.rateInput, this.onStarPressed);
  _RateBarState createState() => _RateBarState(rateInput, onStarPressed);
}

class _RateBarState extends State<RateBarState> {
  int rateInput;
  ValueChanged<int> onStarPressed;

  _RateBarState(this.rateInput, this.onStarPressed);

  List<StarIconButton> _stars = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _buildStarRateWidget();
    return Container(
      color: Colors.white70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _stars,
      ),
    );
  }

  void _buildStarRateWidget() {
    _stars = [];
    for (int i = 1; i < 6; i++) {
      Color color = Colors.grey;
      if (i <= rateInput) color = Colors.amber;
      StarIconButton icon = StarIconButton(
        position: i,
        color: color,
        onStarPressed: (position) {
          setState(() {
            rateInput = position;
            onStarPressed(position);
          });
        },
      );
      _stars.add(icon);
    }

  }
}
