import 'package:app_student/api/day_schedule/entities/day_schedule_entity.dart';

class WeekScheduleEntity {
  final String code;
  final List<DayScheduleEntity> daySchedules;

  WeekScheduleEntity({
    required this.code,
    required this.daySchedules,
  });

  factory WeekScheduleEntity.fromJson(Map<String, dynamic> json) {
    var daySchedulesFromJson = json['DaySchedule'] as List;
    List<DayScheduleEntity> daySchedulesList =
        daySchedulesFromJson.map((i) => DayScheduleEntity.fromJson(i)).toList();

    return WeekScheduleEntity(
      code: json['code'],
      daySchedules: daySchedulesList,
    );
  }
}
