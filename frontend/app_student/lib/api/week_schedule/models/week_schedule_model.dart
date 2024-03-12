import 'package:app_student/api/day_schedule/entities/day_schedule_entity.dart';

import '../entities/week_schedule_entity.dart';

class WeekScheduleModel {
  final WeekScheduleEntity weekSchedule;

  WeekScheduleModel({
    required this.weekSchedule,
  });

  String get code => weekSchedule.code;
  List<DayScheduleEntity> get daySchedules => weekSchedule.daySchedules;
}
