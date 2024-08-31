import 'package:flutter/material.dart';
import 'package:notification_app/local_notification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotification.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification App"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //? basic notification
          ListTile(
            onTap: () async {
              await LocalNotification.showBasicNotification();
            },
            leading: const Icon(Icons.notifications),
            title: const Text("Basic Notification"),
            trailing: IconButton(
              onPressed: () async {
                LocalNotification.cancelNotification(0);
              },
              icon: const Icon(Icons.cancel, color: Colors.red),
            ),
          ),
          //? repeated notification
          ListTile(
            onTap: () async {
              await LocalNotification.showRepeatedNotification();
            },
            leading: const Icon(Icons.notifications),
            title: const Text("Repeated Notification"),
            trailing: IconButton(
              onPressed: () {
                LocalNotification.cancelNotification(1);
              },
              icon: const Icon(Icons.cancel, color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
