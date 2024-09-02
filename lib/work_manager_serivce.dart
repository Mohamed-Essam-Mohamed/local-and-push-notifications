import 'package:notification_app/local_notification.dart';
import 'package:workmanager/workmanager.dart';

class WorkManagerService {
  Duration scheduledDate = const Duration(hours: 12);
  late DateTime date;
  WorkManagerService() {
    date = DateTime.now();
  }

  void checkDate() async {
    if (date.hour == 9) {
      scheduledDate = const Duration(hours: 24);
    } else if (date.hour > 9) {
      int hours = (24 - date.hour) + 9;
      scheduledDate = Duration(hours: hours);
    } else if (date.hour < 9) {
      int hours = 9 - date.hour;
      scheduledDate = Duration(hours: hours);
    }
  }

  Future<void> init() async {
    checkDate();
    await Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: true,
    );
    await Workmanager().registerPeriodicTask(
      "task-identifier 1",
      "simpleTask",
      frequency: scheduledDate,
    );
  }

  void cancelTask(String id) async {
    await Workmanager().cancelByUniqueName(id);
  }
}

///
@pragma('vm:entry-point')
void callbackDispatcher() async {
  Workmanager().executeTask(
    (task, inputData) {
      LocalNotification
          .showDailyScheduledNotification(); // simpleTask will be emitted here.
      return Future.value(true);
    },
  );
}
