import 'package:flutter/material.dart';

class FloatImagePickerButton extends StatelessWidget {
  VoidCallback onCameraClicked;
  VoidCallback onFileSystemClicked;
  VoidCallback onRotateImageClicked;
  VoidCallback onUploadPressed;

  FloatImagePickerButton(
      {@required this.onCameraClicked,
      @required this.onFileSystemClicked,
      @required this.onRotateImageClicked,
      @required this.onUploadPressed});

  @override
  Widget build(BuildContext context) {
    return FloatImagePickerButtonState(onCameraClicked, onFileSystemClicked,
        onRotateImageClicked, onUploadPressed);
  }
}

class FloatImagePickerButtonState extends StatefulWidget {
  VoidCallback onCameraClicked;
  VoidCallback onFileSystemClicked;
  VoidCallback onRotateImageClicked;
  VoidCallback onUploadPressed;

  FloatImagePickerButtonState(this.onCameraClicked, this.onFileSystemClicked,
      this.onRotateImageClicked, this.onUploadPressed);

  _FloatImagePickerButtonState createState() => _FloatImagePickerButtonState();
}

class _FloatImagePickerButtonState extends State<FloatImagePickerButtonState>
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

  Widget uploadPicture() {
    return Container(
      child: FloatingActionButton(
        heroTag: 'uploadPicture',
        onPressed: () {
          animate();
          this.widget.onUploadPressed();
        },
        tooltip: 'Upload Picture',
        child: Icon(Icons.file_upload),
      ),
    );
  }

  Widget cameraButton() {
    return Container(
      child: FloatingActionButton(
        heroTag: 'cameraButton',
        onPressed: () {
          animate();
          this.widget.onCameraClicked();
        },
        tooltip: 'Camera',
        child: Icon(Icons.camera_alt),
      ),
    );
  }

  Widget fileSystemButton() {
    return new Container(
      child: FloatingActionButton(
        heroTag: 'fileSystemButton',
        onPressed: () {
          animate();
          this.widget.onFileSystemClicked();
        },
        tooltip: 'File System',
        child: Icon(Icons.insert_drive_file),
      ),
    );
  }

  Widget rotateImageButton() {
    return new Container(
      child: FloatingActionButton(
        heroTag: 'rotateImageButton',
        onPressed: () {
          //animate();
          this.widget.onRotateImageClicked();
        },
        tooltip: 'File System',
        child: Icon(Icons.rotate_left),
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

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 4.0,
            0.0,
          ),
          child: uploadPicture(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 3.0,
            0.0,
          ),
          child: rotateImageButton(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 2.0,
            0.0,
          ),
          child: cameraButton(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value,
            0.0,
          ),
          child: fileSystemButton(),
        ),
        toggle(),
      ],
    );
  }
}
