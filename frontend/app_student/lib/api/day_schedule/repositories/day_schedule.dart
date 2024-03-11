import 'package:app_student/api/api_service.dart';
import '../entities/day_schedule_entity.dart';

class DayScheduleRepository {
  final String className;
  final ApiService apiService;

  DayScheduleRepository({required this.className, required this.apiService});

Future<List<DayScheduleEntity>> getDaySchedule($className) {
  return apiService.getData('/api/timetable?class_param=$className',
      (item) => DayScheduleEntity.fromJson(item));
}
}
