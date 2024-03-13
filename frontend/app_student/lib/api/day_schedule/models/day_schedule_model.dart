import 'package:app_student/api/events/models/event_model.dart';
import '../entities/day_schedule_entity.dart';

class DayScheduleModel {
  final DayScheduleEntity entity;

  DayScheduleModel({required this.entity});

  DateTime get date => entity.date;

  int get jour => entity.jour;

  List<EventModel> get events => entity.events.map((e) => EventModel(entity: e)).toList();

  factory DayScheduleModel.fromEntity(DayScheduleEntity entity) {
    return DayScheduleModel(
      entity: entity,
    );
  }
}
