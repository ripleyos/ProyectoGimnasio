import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  static const _keyNotificationsEnabled = 'notifications_enabled';

  static Future<void> _saveNotificationSettings(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyNotificationsEnabled, value);
  }

  static Future<bool> _loadNotificationSettings() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyNotificationsEnabled) ?? true; // Valor predeterminado: true
  }
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    final InitializationSettings initializationSettings =
    InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: IOSInitializationSettings(),
    );

    await _notificationsPlugin.initialize(initializationSettings);
  }

  static Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    bool notificationsEnabled = await _loadNotificationSettings();

    if (notificationsEnabled) {
      final AndroidNotificationDetails androidDetails =
      AndroidNotificationDetails(
        'main_channel',
        'Main Channel',
        importance: Importance.max,
        priority: Priority.high,
      );

      final NotificationDetails details = NotificationDetails(
        android: androidDetails,
        iOS: IOSNotificationDetails(),
      );

      await _notificationsPlugin.show(id, title, body, details);
    }
  }

}
