import '../../events/entities/event_entity.dart';
import '../entities/day_schedule_entity.dart';

class DayScheduleModel {
  final DaySchedule entity;

  DayScheduleModel({required this.entity});

  DateTime get date => entity.date;
  int get jour => entity.jour;
  List<EventEntity> get events => entity.events;
}
