import 'package:flutter/material.dart';

class FloatAlbumButton extends StatelessWidget {
  VoidCallback onAddPicturePressed;

  FloatAlbumButton({@required this.onAddPicturePressed});

  @override
  Widget build(BuildContext context) {
    return FloatAlbumButtonState(onAddPicturePressed);
  }
}

class FloatAlbumButtonState extends StatefulWidget {
  VoidCallback onAddPicturePressed;

  FloatAlbumButtonState(this.onAddPicturePressed);

  _FloatAlbumButtonState createState() => _FloatAlbumButtonState();
}

class _FloatAlbumButtonState extends State<FloatAlbumButtonState>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;

  @override
  initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(
      begin: Colors.blue,
      end: Colors.red,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    ));
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  Widget addPicture() {
    return Container(
      child: FloatingActionButton(
        heroTag: 'addPicture',
        onPressed: () {
          animate();
          this.widget.onAddPicturePressed();
        },
        tooltip: 'Add picture',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  Widget toggle() {
    return FloatingActionButton(
      heroTag: 'toggle',
      backgroundColor: _buttonColor.value,
      onPressed: animate,
      tooltip: 'Toggle',
      child: AnimatedIcon(
        icon: AnimatedIcons.menu_close,
        progress: _animateIcon,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value,
            0.0,
          ),
          child: addPicture(),
        ),
        toggle(),
      ],
    );
  }
}
