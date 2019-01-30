import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:prayer_app/resources/config.dart';

class FirebaseMessagingUtils {
  static final String _churchTopic = 'church';
  static final String _userTopic = 'user';
  static final String _prayTopic = 'pray';
  static final String _topic = '/topics/';

  static const int ADD_USER_TO_CHURCH = 1;
  static const int ADD_USER_TO_PRAY = 2;

  static final FirebaseMessagingUtils _firebaseMessagingUtils =
      FirebaseMessagingUtils._internal();

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  factory FirebaseMessagingUtils() {
    return _firebaseMessagingUtils;
  }

  FirebaseMessagingUtils._internal();

  void firebaseCloudMessagingListeners({
    MessageHandler onMessage,
    MessageHandler onLaunch,
    MessageHandler onResume,
  }) {
    if (Platform.isIOS) iOSPermission();

    _firebaseMessaging.getToken().then((token) {
      print(token);
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async => onMessage(message),
      onResume: (Map<String, dynamic> message) async => onResume(message),
      onLaunch: (Map<String, dynamic> message) async => onLaunch(message),
    );
  }

  void subscribeToUserTopic(int idUser) {
    if (idUser == null) return;
    String topic = firebaseEnv + _userTopic + idUser.toString();
    _firebaseMessaging.subscribeToTopic(topic);
  }

  void unsubscribeFromUserTopic(int idUser) {
    if (idUser == null) return;
    String topic = firebaseEnv + _userTopic + idUser.toString();
    _firebaseMessaging.unsubscribeFromTopic(topic);
  }

  void subscribeToChurchTopic(int idChurch) {
    if (idChurch == null) return;
    String topic = firebaseEnv + _churchTopic + idChurch.toString();
    _firebaseMessaging.subscribeToTopic(topic);
  }

  void unsubscribeFromChurchTopic(int idChurch) {
    if (idChurch == null) return;
    String topic = firebaseEnv + _churchTopic + idChurch.toString();
    _firebaseMessaging.unsubscribeFromTopic(topic);
  }

  void iOSPermission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  void sendToUserTopic(int idUser, String title, String message,
      Map<String, dynamic> data) async {
    String topic = _topic + firebaseEnv + _userTopic + idUser.toString();
    Map<String, dynamic> body =
        _buildNotificationPayload(topic, title, message, data);
    var send = json.encode(body);
    final response = await http.post("https://fcm.googleapis.com/fcm/send",
        headers: {
          "Content-Type": "application/json",
          "Authorization": "key=" + firebaseServerKey
        },
        body: send);
    if (response.statusCode == 200) {
      print("Successfully send");
    }
  }

  Map<String, dynamic> _buildNotificationPayload(
          String topic, String title, String body, Map<String, dynamic> data) =>
      {
        'to': topic,
        'notification': {'title': title, 'body': body},
        'data': data,
      };

  void subscribeToPrayTopic(int idPray) {
    if (idPray == null) return;
    String topic = firebaseEnv + _prayTopic + idPray.toString();
    _firebaseMessaging.subscribeToTopic(topic);
  }
}
