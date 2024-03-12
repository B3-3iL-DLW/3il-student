import '../entities/event_hours_entity.dart';

class EventHoursModel {
  final EventHoursEntity entity;

  EventHoursModel({required this.entity});

  String get startAt => entity.startAt;
  String get endAt => entity.endAt;
}
