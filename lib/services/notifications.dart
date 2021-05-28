import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// IMP : await flutterLocalNotificationsPlugin.cancelAll();

class NotificationService {
  static final NotificationService _notificationService =
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  Future<void> init() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');

    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,
        macOS: null
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: (payload) { return; });
  }

  cancelNotifications() async {
    print("yello");
    await flutterLocalNotificationsPlugin.cancelAll();
    await flutterLocalNotificationsPlugin.cancel(0);
  }

}