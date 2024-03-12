import 'package:app_student/api/day_schedule/entities/day_schedule_entity.dart';

class WeekScheduleEntity {
  final String code;
  final List<DayScheduleEntity> daySchedules;

  WeekScheduleEntity({
    required this.code,
    required this.daySchedules,
  });

  factory WeekScheduleEntity.fromJson(Map<String, dynamic> json) {
    return WeekScheduleEntity(
      code: json['code'],
      daySchedules: (json['DaySchedule'] as List<dynamic>)
          .map((daySchedule) =>
              DayScheduleEntity.fromJson(daySchedule as Map<String, dynamic>))
          .toList(),
    );
  }
}
