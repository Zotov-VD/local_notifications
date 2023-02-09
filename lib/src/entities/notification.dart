import 'package:equatable/equatable.dart';

class LocalNotification extends Equatable {
  final String? title;
  final String? body;
  final String? androidChannelId;
  final Map<String, dynamic>? data;

  const LocalNotification({
    this.title,
    this.body,
    this.androidChannelId,
    this.data,
  });

  @override
  List<Object?> get props => [
        title,
        body,
        androidChannelId,
        data,
      ];
}
