import 'dart:developer';
import 'dart:ffi';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotification {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  String? token;

  Future initialize() async {
    await messaging.requestPermission();
    await onBackgroundMessageFunction();
    token = await messaging.getToken();
    log("token: $token");
  }

  Future onBackgroundMessageFunction() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  log("Handling a background message: ${message.messageId}");
}
