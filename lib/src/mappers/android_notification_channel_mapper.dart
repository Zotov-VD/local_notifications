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
      importance: plugin.Importance(from.importance.value),
    );
  }
}
