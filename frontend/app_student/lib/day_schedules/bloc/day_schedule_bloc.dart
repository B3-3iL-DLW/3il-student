import 'dart:async';
import 'package:app_student/api/day_schedule/entities/day_schedule.dart';
import 'package:app_student/api/day_schedule/repositories/day_schedule.dart';

class DayScheduleBloc {
  final DayScheduleRepository dayScheduleRepository;
  final _dayScheduleController = StreamController<List<DaySchedule>>();

  Stream<List<DaySchedule>> get dayScheduleStream =>
      _dayScheduleController.stream;

  DayScheduleBloc({required this.dayScheduleRepository}) {
    fetchDaySchedules('B3 GROUPE 3 DLW-FA');
    // TODO : get the class name from the shared preferences
  }

  fetchDaySchedules(String className) async {
    final daySchedules = await dayScheduleRepository.getDaySchedules(className);
    _dayScheduleController.sink.add(daySchedules);
  }

  dispose() {
    _dayScheduleController.close();
  }
}
