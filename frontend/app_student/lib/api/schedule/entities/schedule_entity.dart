import 'package:app_student/api/week_schedule/entities/week_schedule_entity.dart';

class ScheduleEntity {
  final int id;
  final List<WeekScheduleEntity> weekSchedules;

  ScheduleEntity({
    required this.id,
    required this.weekSchedules,
  });

  factory ScheduleEntity.fromJson(Map<String, dynamic> json) {
    var weekSchedulesFromJson = json['Weeks'] as List;
    List<WeekScheduleEntity> weekSchedulesList = weekSchedulesFromJson
        .map((i) => WeekScheduleEntity.fromJson(i))
        .toList();

    return ScheduleEntity(
      id: json['id'],
      weekSchedules: weekSchedulesList,
    );
  }
}
