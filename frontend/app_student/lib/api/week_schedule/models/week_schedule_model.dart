import 'package:app_student/api/day_schedule/entities/day_schedule_entity.dart';

class WeekScheduleModel {
  final String code;
  final List<DayScheduleEntity> daySchedules;

  WeekScheduleModel({
    required this.code,
    required this.daySchedules,
  });
}
