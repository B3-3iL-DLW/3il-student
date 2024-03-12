import '../../events/entities/event_entity.dart';

class DayScheduleEntity {
  final DateTime date;
  final int jour;
  final List<EventEntity> events;

  DayScheduleEntity({
    required this.date,
    required this.jour,
    required this.events,
  });

  factory DayScheduleEntity.fromJson(Map<String, dynamic> json) {
    var eventsFromJson = json['events'] as List;
    List<EventEntity> eventsList =
        eventsFromJson.map((i) => EventEntity.fromJson(i)).toList();

    DateTime date = DateTime.parse(json['date']);

    return DayScheduleEntity(
      date: date,
      jour: json['jour'],
      events: eventsList,
    );
  }
}
