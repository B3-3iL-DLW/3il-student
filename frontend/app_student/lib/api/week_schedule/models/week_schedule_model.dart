import 'package:app_student/api/day_schedule/models/day_schedule_model.dart';
import '../entities/week_schedule_entity.dart';

class WeekScheduleModel {
  final String code;
  final List<DayScheduleModel> daySchedules;

  WeekScheduleModel({
    required this.code,
    required this.daySchedules,
  });

  factory WeekScheduleModel.fromEntity(WeekScheduleEntity entity) {
    return WeekScheduleModel(
      code: entity.code,
      daySchedules: entity.daySchedules.map((dayScheduleEntity) => DayScheduleModel.fromEntity(dayScheduleEntity)).toList(),
    );
  }
}