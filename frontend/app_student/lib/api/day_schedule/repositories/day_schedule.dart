import 'package:app_student/api/api_service.dart';
import '../entities/day_schedule.dart';

class DayScheduleRepository {
  final String className;
  final ApiService apiService;

  DayScheduleRepository({required this.className, required this.apiService});

  Future<List<DaySchedule>> getDaySchedules($className) {
    return apiService.getData('/api/timetable?class_param=$className',
        (item) => DaySchedule.fromJson(item));
  }
}
