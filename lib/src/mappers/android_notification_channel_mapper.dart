import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    as plugin;

import '../entities/android_notification_channel.dart';

abstract class AndroidNotifcationChannelMapper {
  const AndroidNotifcationChannelMapper._();

  static plugin.AndroidNotificationChannel toPlugin(
      {required AndroidNotificationChannel from}) {
    return plugin.AndroidNotificationChannel(
      from.id,
      from.name,
      importance: switch (from.importance) {
        AndroidImportance.defaultImportance =>
          plugin.Importance.defaultImportance,
        AndroidImportance.max => plugin.Importance.max,
        AndroidImportance.high => plugin.Importance.high,
        AndroidImportance.low => plugin.Importance.low,
        AndroidImportance.min => plugin.Importance.min,
        AndroidImportance.none => plugin.Importance.none,
        AndroidImportance.unspecified => plugin.Importance.unspecified,
      },
    );
  }
}
