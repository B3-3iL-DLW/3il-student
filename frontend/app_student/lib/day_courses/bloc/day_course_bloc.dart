import 'dart:async';
import 'package:app_student/api/day_schedule/entities/day_schedule_entity.dart';
import 'package:app_student/api/day_schedule/repositories/day_schedule.dart';

class DayCourseBloc {
  final DayCourseRepository dayCourseRepository;
  final _dayCourseController = StreamController<List<DayCourse>>();

  Stream<List<DayCourse>> get dayCourseStream => _dayCourseController.stream;

  DayCourseBloc({required this.dayCourseRepository}) {
    fetchDayCourses('B3 GROUPE 3 DLW-FA');
    // TODO : get the class name from the shared preferences
  }

  fetchDayCourses(String className) async {
    final daySchedules = await dayCourseRepository.getDayCourses(className);
    _dayCourseController.sink.add(daySchedules);
  }

  dispose() {
    _dayCourseController.close();
  }
}
