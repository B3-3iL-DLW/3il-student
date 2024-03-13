import '../../events/entities/event_entity.dart';
import '../entities/day_schedule_entity.dart';

class DayScheduleModel {
  final DayScheduleEntity entity;

  DayScheduleModel({required this.entity});

  DateTime get date => entity.date;

  int get jour => entity.jour;

  List<EventEntity> get events => entity.events;

  factory DayScheduleModel.fromEntity(DayScheduleEntity entity) {
    return DayScheduleModel(
      entity: entity,
    );
  }
}
