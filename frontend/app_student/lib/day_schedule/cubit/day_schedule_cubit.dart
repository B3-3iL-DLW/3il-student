import 'package:app_student/api/day_schedule/repositories/day_schedule.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'day_schedule_state.dart';

class DayScheduleCubit extends Cubit<DayScheduleState> {
  final DayScheduleRepository dayScheduleRepository;

  DayScheduleCubit({required this.dayScheduleRepository})
      : super(DayScheduleInitial());

  Future fetchDaySchedule(String className) async {
    try {
      emit(DayScheduleLoading());
      final daySchedule = await dayScheduleRepository.getDaySchedule(className);
      emit(DayScheduleLoaded(daySchedule));
    } catch (e) {
      emit(DayScheduleError(e.toString()));
    }
  }
}



