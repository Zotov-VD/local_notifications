import 'package:flutter/material.dart';
import 'package:local_notifications/local_notifications.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: _Body(),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body();

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  void initState() {
    super.initState();
    LocalNotificationsPlugin().initialize(
      settings: const NotificationsInitializationSettings(
        androidDefaultIcon: 'mipmap/ic_launcher',
        androidChannels: [
          AndroidNotificationChannel(
            id: 'default',
            name: 'Другие',
          ),
          AndroidNotificationChannel(
            id: 'important',
            name: 'Важные',
            importance: AndroidImportance.max,
          ),
          AndroidNotificationChannel(
            id: 'commercial',
            name: 'Рекомандации и скидки',
          ),
          AndroidNotificationChannel(
            id: 'order_status',
            name: 'Статус заказов',
            importance: AndroidImportance.high,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // dd
          ElevatedButton(
            onPressed: () {
              const notification = LocalNotification(
                  id: 1,
                  title: 'Привет',
                  body: 'Как дела?',
                  androidChannelId: 'important');
              LocalNotificationsPlugin().showNotification(notification);
            },
            child: const Text('Показать уведомление'),
          ),
          const SizedBox(height: 14),
          ElevatedButton(
            onPressed: () {
              const notification = LocalNotification(
                  id: 2,
                  title: 'Привет2',
                  body: 'Как дела?',
                  androidChannelId: 'important');
              Future.delayed(
                const Duration(seconds: 3),
                () => LocalNotificationsPlugin().showNotification(notification),
              );
            },
            child: const Text('Показать уведомление через 3 секунды'),
          ),
        ],
      ),
    );
  }
}
