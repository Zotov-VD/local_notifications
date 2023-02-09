import 'package:equatable/equatable.dart';

class AndroidNotificationChannel extends Equatable {
  final String id;
  final String name;
  final AndroidImportance importance;

  const AndroidNotificationChannel({
    required this.id,
    required this.name,
    this.importance = AndroidImportance.defaultImportance,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        importance,
      ];
}

enum AndroidImportance {
  unspecified(-1000),
  none(0),
  min(1),
  low(2),
  defaultImportance(3),
  high(4),
  max(5),
  ;

  final int value;
  const AndroidImportance(this.value);
}
