import '../../events/entities/event_entity.dart';

class DaySchedule {
  final DateTime date;
  final int jour;
  final List<EventEntity> events;

  DaySchedule({
    required this.date,
    required this.jour,
    required this.events,
  });

  factory DaySchedule.fromJson(Map<String, dynamic> json) {
    var eventsFromJson = json['cours'] as List;
    List<EventEntity> eventsList =
        eventsFromJson.map((i) => EventEntity.fromJson(i)).toList();

    return DaySchedule(
      date: json['date'],
      jour: json['jour'],
      events: eventsList,
    );
  }
}
