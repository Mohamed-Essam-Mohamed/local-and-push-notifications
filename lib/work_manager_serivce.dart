import 'package:notification_app/local_notification.dart';
import 'package:workmanager/workmanager.dart';

class WorkManagerService {
  Future<void> init() async {
    await Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: true,
    );
    await Workmanager().registerPeriodicTask(
      "task-identifier",
      "simpleTask",
      frequency: const Duration(minutes: 1),
    );
  }

  void cancelTask(String id) async {
    await Workmanager().cancelByUniqueName(id);
  }
}

@pragma('vm:entry-point')
void callbackDispatcher() async {
  Workmanager().executeTask((task, inputData) {
    LocalNotification
        .showBasicNotification(); //simpleTask will be emitted here.
    return Future.value(true);
  });
}
