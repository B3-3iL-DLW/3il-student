import 'dart:convert';

import 'package:app_student/api/api_service.dart';
import 'package:app_student/api/week_schedule/entities/week_schedule_entity.dart';
import 'package:app_student/api/week_schedule/models/week_schedule_model.dart';

class WeekScheduleRepository {
  final ApiService apiService;

  WeekScheduleRepository({required this.apiService, required String className});

  Future<List<WeekScheduleModel>> getWeeksSchedule(className) {
    return apiService.getData('/api/timetable?class_param=$className', (item) {
      final entity = WeekScheduleEntity.fromJson(item);
      return WeekScheduleModel(
        code: entity.code,
        daySchedules: entity.daySchedules,
      );
    });
  }
}
