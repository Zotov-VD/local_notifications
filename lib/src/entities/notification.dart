import 'package:equatable/equatable.dart';

class LocalNotification extends Equatable {
  final int id;
  final String? title;
  final String? body;
  final String? androidChannelId;
  final Map<String, dynamic>? data;

  const LocalNotification({
    required this.id,
    this.title,
    this.body,
    this.androidChannelId,
    this.data,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        body,
        androidChannelId,
        data,
      ];
}
