import 'package:app_student/api/week_schedule/repositories/week_schedule_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'week_schedule_state.dart';

class WeekScheduleCubit extends Cubit<WeekScheduleState> {
  final WeekScheduleRepository weekScheduleRepository;

  WeekScheduleCubit({required this.weekScheduleRepository})
      : super(WeekScheduleInitial());

  Future fetchWeekSchedule(String className) async {
    try {
      emit(WeekScheduleLoading());
      final weekSchedule =
          await weekScheduleRepository.getWeeksSchedule(className);
      emit(WeekScheduleLoaded(weekSchedule));
    } catch (e) {
      emit(WeekScheduleError(e.toString()));
    }
  }
}
