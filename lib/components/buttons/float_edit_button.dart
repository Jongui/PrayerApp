import 'package:flutter/material.dart';

class FloatEditButton extends StatefulWidget {
//  VoidCallback onEditPressed;
//  VoidCallback onAddPressed;
//  VoidCallback onAlbumClicked;

//  FloatEditButton(
//      {@required this.onAddPressed,
//      @required this.onEditPressed,
//      @required this.onAlbumClicked});
//
//  @override
//  Widget build(BuildContext context) {
//    return FloatEditButtonState(
//        onAddPressed, onEditPressed, onAlbumClicked);
//  }
//}
//
//class FloatEditButtonState extends StatefulWidget {
  VoidCallback onEditPressed;
  VoidCallback onAddPressed;
  VoidCallback onAlbumClicked;

  FloatEditButton({@required this.onAddPressed,
    @required this.onEditPressed,
    @required this.onAlbumClicked});

  @override
  _FloatEditButtonState createState() => _FloatEditButtonState();
}

class _FloatEditButtonState extends State<FloatEditButton>
    with SingleTickerProviderStateMixin {
  _FloatEditButtonState();

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

  Widget addUser() {
    return new Container(
      child: FloatingActionButton(
        heroTag: 'addUser',
        onPressed: () {
          animate();
          this.widget.onAddPressed();
        },
        tooltip: 'Add user',
        child: Icon(Icons.person_add),
      ),
    );
  }

  Widget edit() {
    return new Container(
      child: FloatingActionButton(
        heroTag: 'editChurch',
        onPressed: () {
          animate();
          this.widget.onEditPressed();
        },
        tooltip: 'Edit Church',
        child: Icon(Icons.mode_edit),
      ),
    );
  }

  Widget viewAlbum() {
    return new Container(
      child: FloatingActionButton(
        heroTag: 'viewAlbum',
        onPressed: () {
          animate();
          this.widget.onAlbumClicked();
        },
        tooltip: 'View Album',
        child: Icon(Icons.photo_album),
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
            _translateButton.value * 3.0,
            0.0,
          ),
          child: viewAlbum(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 2.0,
            0.0,
          ),
          child: addUser(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value,
            0.0,
          ),
          child: edit(),
        ),
        toggle(),
      ],
    );
  }
}
