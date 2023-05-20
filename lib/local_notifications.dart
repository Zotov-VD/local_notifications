library local_notifications;

import 'dart:convert';
import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    hide AndroidNotificationChannel;
import 'package:local_notifications/src/entities/notification.dart';
import 'package:local_notifications/src/mappers/android_notification_channel_mapper.dart';

import 'src/entities/android_notification_channel.dart';
import 'src/entities/notifications_initialization_settings.dart';

export 'src/entities/android_notification_channel.dart';
export 'src/entities/notification.dart';
export 'src/entities/notifications_initialization_settings.dart';

class LocalNotificationsPlugin {
  factory LocalNotificationsPlugin() => _instance;

  static final LocalNotificationsPlugin _instance =
      LocalNotificationsPlugin._();

  LocalNotificationsPlugin._();

  FlutterLocalNotificationsPlugin get _plugin =>
      FlutterLocalNotificationsPlugin();

  Future<bool?> initialize({
    required NotificationsInitializationSettings settings,
    Function(Map<String, dynamic> payload)? onTapped,
  }) async {
    if (Platform.isAndroid) {
      await createAndroidChannels(settings.androidChannels);
    }
    return _plugin.initialize(
      InitializationSettings(
        android: AndroidInitializationSettings(settings.androidDefaultIcon),
        iOS: const DarwinInitializationSettings(),
      ),
      onDidReceiveNotificationResponse: (details) {
        if (details.payload != null) {
          onTapped?.call(jsonDecode(details.payload!));
        }
      },
    );
  }

  List<AndroidNotificationChannel> _androidChannels = [];

  Future<void> createAndroidChannels(
      List<AndroidNotificationChannel> channels) async {
    _androidChannels = channels;
    for (final channel in channels) {
      await _plugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(
              AndroidNotifcationChannelMapper.toPlugin(from: channel));
    }
  }

  NotificationDetails _getNotificationDetails(LocalNotification notification) {
    AndroidNotificationDetails? androidDetails;
    DarwinNotificationDetails? appleDetails;
    if (Platform.isAndroid) {
      AndroidNotificationChannel? channel;
      for (final c in _androidChannels) {
        if (c.id == notification.androidChannelId) {
          channel = c;
          break;
        }
      }
      channel ??= _androidChannels.first;

      androidDetails = AndroidNotificationDetails(
        channel.id,
        channel.name,
        importance: Importance(channel.importance.value),
      );
    } else if (Platform.isIOS) {
      appleDetails = const DarwinNotificationDetails();
    }
    return NotificationDetails(
      android: androidDetails,
      iOS: appleDetails,
    );
  }

  Future<void> showNotification(LocalNotification notification) {
    return _plugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      _getNotificationDetails(notification),
      payload: notification.data != null ? jsonEncode(notification.data) : null,
    );
  }
}
