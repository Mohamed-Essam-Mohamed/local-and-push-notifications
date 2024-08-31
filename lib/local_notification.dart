import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification {
  static FlutterLocalNotificationsPlugin fLNotification =
      FlutterLocalNotificationsPlugin();
  static onTap(NotificationResponse details) {}
  static Future init() async {
    InitializationSettings initSettings = const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    fLNotification.initialize(
      initSettings,
      onDidReceiveBackgroundNotificationResponse: onTap,
      onDidReceiveNotificationResponse: onTap,
    );
  }

  static Future<void> showBasicNotification() async {
    NotificationDetails notificationDetails = const NotificationDetails(
      android: AndroidNotificationDetails(
        'id 1',
        'basic Notification',
        //? show when app is in foreground
        importance: Importance.max,
        priority: Priority.high,
      ),
    );
    await fLNotification.show(
      0,
      'Basic Notification',
      'body',
      notificationDetails,
      payload: 'data',
    );
  }

  static Future<void> showRepeatedNotification() async {
    NotificationDetails notificationDetails = const NotificationDetails(
      android: AndroidNotificationDetails(
        'id 1',
        'basic Notification',
        //? show when app is in foreground
        importance: Importance.max,
        priority: Priority.high,
      ),
    );

    await fLNotification.periodicallyShow(
      1,
      'Repeated Notification',
      'body',
      RepeatInterval.everyMinute,
      notificationDetails,
    );
  }

  static void cancelNotification(int id) async {
    await fLNotification.cancel(id);
  }
}
