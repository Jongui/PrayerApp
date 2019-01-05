import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prayer_app/components/dialogs/process_dialog.dart';
import 'package:prayer_app/localizations.dart';
import 'package:prayer_app/screens/loading_screen/loading_view.dart';
import 'package:image/image.dart' as im;

class TakePictureScreen extends StatefulWidget {
  final ValueChanged<String> onTakePicture;

  TakePictureScreen({@required this.onTakePicture});

  @override
  _TakePictureScreenState createState() {
    return _TakePictureScreenState();
  }
}

/// Returns a suitable camera icon for [direction].
IconData getCameraLensIcon(CameraLensDirection direction) {
  switch (direction) {
    case CameraLensDirection.back:
      return Icons.camera_rear;
    case CameraLensDirection.front:
      return Icons.camera_front;
    case CameraLensDirection.external:
      return Icons.camera;
  }
  throw ArgumentError('Unknown lens direction');
}

void logError(String code, String message) =>
    print('Error: $code\nError Message: $message');

class _TakePictureScreenState extends State<TakePictureScreen> {
  CameraController controller;
  String imagePath;
  List<CameraDescription> cameras;
  Widget _view;
  //BuildContext _context;
  VoidCallback controllerListener;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _view = LoadingView();
    _handleCameraLoad();
    super.initState();
  }

  @override
  void deactivate() {
    if (controller != null) {
      controller.removeListener(controllerListener);
    }
    super.deactivate();
  }

  @override
  void dispose() {
    if (controller != null) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).takeAPicture),
      ),
      body: _view,
    );
  }

  /// Display the preview from the camera (or a message if the preview is not available).
  Widget _cameraPreviewWidget(BuildContext context) {
    if (controller == null || !controller.value.isInitialized) {
      return Text(
        AppLocalizations.of(context).tapACamera,
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
      );
    } else {
      return AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: CameraPreview(controller),
      );
    }
  }

  /// Display a row of toggle to select the camera (or a message if no camera is available).
  Widget _cameraTogglesRowWidget() {
    final List<Widget> toggles = <Widget>[];

    if (cameras.isEmpty) {
      return const Text('No camera found');
    } else {
      for (CameraDescription cameraDescription in cameras) {
        toggles.add(
          SizedBox(
            width: 90.0,
            child: RadioListTile<CameraDescription>(
              title: Icon(getCameraLensIcon(cameraDescription.lensDirection)),
              groupValue: controller?.description,
              value: cameraDescription,
              onChanged: controller != null && controller.value.isRecordingVideo
                  ? null
                  : onNewCameraSelected,
            ),
          ),
        );
      }
    }

    return Row(children: toggles);
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  void showInSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }
    controller = CameraController(cameraDescription, ResolutionPreset.high);

    // If the controller is updated then update the UI.
    controllerListener = () {
      if (mounted) setState(() {});
      if (controller.value.hasError) {
        showInSnackBar('Camera error ${controller.value.errorDescription}');
      }
    };
    controller.addListener(controllerListener);

    try {
      await controller.initialize();
    } on CameraException catch (e) {
      _showCameraException(e);
    }

    if (mounted) {
      setState(() {
        _view = _buildCameraView(context);
      });
    }
  }

  void onTakePictureButtonPressed() {
    showDialog(
        context: context,
        builder: (_) => ProcessDialog(
              text: AppLocalizations.of(context).takingPicture,
            ));
    takePicture().then((String filePath) {
      File _tmpFile = File(filePath);
      im.Image _tmpImage = im.decodeImage(_tmpFile.readAsBytesSync());
      im.Image _resizedImg = im.copyResize(_tmpImage, 800);

      _tmpFile = File(filePath)
        ..writeAsBytesSync(im.encodeJpg(_resizedImg));

      this.widget.onTakePicture(filePath);
      if (mounted) {
        setState(() {
          //imagePath = filePath;
          _view = _buildCameraView(context);
        });
        if (filePath != null) {
          showInSnackBar(AppLocalizations.of(context).pictureTaken);
        }
      }
      Navigator.pop(context);
    });
  }

  Future<String> takePicture() async {
    if (!controller.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return null;
    }
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.jpg';

    if (controller.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      await controller.takePicture(filePath);
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
    return filePath;
  }

  void _showCameraException(CameraException e) {
    logError(e.code, e.description);
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }

  Widget _buildCameraView(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 108.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _cameraTogglesRowWidget(),
//              _thumbnailWidget(),
            ],
          ),
        ),
        Expanded(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Center(
                child: _cameraPreviewWidget(context),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(
                color: controller != null && controller.value.isRecordingVideo
                    ? Colors.redAccent
                    : Colors.grey,
                width: 3.0,
              ),
            ),
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.camera_alt,
            size: 45.0,
          ),
          color: Colors.blue,
          onPressed: controller != null &&
                  controller.value.isInitialized &&
                  !controller.value.isRecordingVideo
              ? onTakePictureButtonPressed
              : null,
        ),
      ],
    );
  }

  void _handleCameraLoad() async {
    try {
      cameras = await availableCameras();
    } on CameraException catch (e) {
      logError(e.code, e.description);
      return;
    }
    setState(() {
      _view = _buildCameraView(context);
    });
  }

}
