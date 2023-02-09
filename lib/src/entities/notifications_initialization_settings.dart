import 'android_notification_channel.dart';

class NotificationsInitializationSettings {
  final String androidDefaultIcon;
  final List<AndroidNotificationChannel> androidChannels;

  const NotificationsInitializationSettings({
    required this.androidDefaultIcon,
    required this.androidChannels,
  });
}
