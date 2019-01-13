import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:prayer_app/resources/config.dart';

class FirebaseMessagingUtils{

  static final String _churchTopic = 'church';

  static final FirebaseMessagingUtils _firebaseMessagingUtils = FirebaseMessagingUtils._internal();

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  factory FirebaseMessagingUtils(){
    return _firebaseMessagingUtils;
  }

  FirebaseMessagingUtils._internal();

  void firebaseCloudMessagingListeners() {
    if (Platform.isIOS) iOSPermission();

    _firebaseMessaging.getToken().then((token){
      print(token);
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }

  void subscribeToChurchTopic(int idChurch){
    if(idChurch == null) return;
    String topic = firebaseEnv + _churchTopic + idChurch.toString();
    _firebaseMessaging.subscribeToTopic(topic);
  }

  void unsubscribeFromTopic(int idChurch){
    if(idChurch == null) return;
    String topic = firebaseEnv + _churchTopic + idChurch.toString();
    _firebaseMessaging.unsubscribeFromTopic(topic);
  }

  void iOSPermission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true)
    );
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings)
    {
      print("Settings registered: $settings");
    });
  }

}
