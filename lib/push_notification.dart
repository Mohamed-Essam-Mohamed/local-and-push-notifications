import 'dart:developer';
import 'dart:ffi';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:notification_app/local_notification.dart';

class PushNotification {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  String? token;

  Future initialize() async {
    await messaging.requestPermission();
    await onBackgroundMessageFunction();
    await onMessageFunction();
    token = await messaging.getToken();
    log("token: $token");
  }

  Future onBackgroundMessageFunction() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  Future onMessageFunction() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Got a message whilst in the foreground!');
      log('Message data: ${message.notification?.title}');
      LocalNotification.showBasicNotification(message: message);
    });
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  log("Handling a background message: ${message.messageId}");
}
