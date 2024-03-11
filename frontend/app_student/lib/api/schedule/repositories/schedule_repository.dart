import 'package:app_student/api/api_service.dart';
import 'package:app_student/api/schedule/entities/schedule_entity.dart';
import 'package:app_student/api/schedule/models/schedule_model.dart';

class ScheduleRepository {
  final ApiService apiService;
  final String className;

  ScheduleRepository({required this.apiService, required this.className});

  Future<ScheduleModel> getSchedule(className) {
    return apiService.getData('/api/timetable?class_param=$className', (item) {
      final entity = ScheduleEntity.fromJson(item);
      return ScheduleModel(schedule: entity);
    }).then((list) => list.first);
  }
}
