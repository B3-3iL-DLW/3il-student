import 'package:app_student/api/schedule/entities/schedule_entity.dart';
import 'package:app_student/api/week_schedule/entities/week_schedule_entity.dart';

class ScheduleModel {
  final ScheduleEntity schedule;

  ScheduleModel({required this.schedule});

  int get id => schedule.id;
  List<WeekScheduleEntity> get weekSchedules => schedule.weekSchedules;
}
