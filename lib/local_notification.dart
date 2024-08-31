//? flutter_local_notifications => package
//? timezone => package   use this package to inti scheduled notification. doc this package in flutter_local_notifications
//? flutter_timezone => package   use this package to get location timezone

import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotification {
  static FlutterLocalNotificationsPlugin fLNotification =
      FlutterLocalNotificationsPlugin();
  //! connected onTap notification to ui screen
  //?  1
  static StreamController<NotificationResponse> controller = StreamController();
  //?  2
  static onTap(NotificationResponse details) {
    controller.add(details);
  }

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

  //? basic notification
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
      payload: 'data Basic Notification',
    );
  }

  //? repeated notification
  static Future<void> showRepeatedNotification() async {
    NotificationDetails notificationDetails = const NotificationDetails(
      android: AndroidNotificationDetails(
        'id 2',
        'repeated Notification',
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
      payload: 'data Repeated Notification',
    );
  }

  //? scheduled notification
  static Future<void> showScheduledNotification() async {
    NotificationDetails notificationDetails = const NotificationDetails(
      android: AndroidNotificationDetails(
        'id 3',
        'Scheduled Notification',
        //? show when app is in foreground
        importance: Importance.max,
        priority: Priority.high,
      ),
    );
    tz.initializeTimeZones();
    //! get location by flutter_timezone
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    //! update location in package timezone
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, now.hour, 48);

    await fLNotification.zonedSchedule(
      2,
      'Scheduled Notification',
      'body',
      // tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10)),
      scheduledDate,
      notificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: 'data Scheduled Notification',
    );
  }

  static void cancelNotification(int id) async {
    await fLNotification.cancel(id);
  }
}
