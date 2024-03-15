import 'package:app_student/api/day_schedule/models/day_schedule_model.dart';
import 'package:app_student/api/users/models/user_model.dart';
import 'package:app_student/api/week_schedule/models/week_schedule_model.dart';
import 'package:app_student/api/week_schedule/repositories/week_schedule_repository.dart';
import 'package:app_student/users/cubit/user_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'week_schedule_state.dart';

class WeekScheduleCubit extends Cubit<WeekScheduleState> {
  final WeekScheduleRepository weekScheduleRepository;
  final UserCubit userCubit;
  late DateTime? initialDate;

  WeekScheduleCubit(
      {required this.weekScheduleRepository,
      required this.userCubit,
      required this.initialDate})
      : super(WeekScheduleInitial());

  Future fetchWeekSchedule() async {
    try {
      if (isClosed) return;
      emit(WeekScheduleLoading());
      final user = await userCubit.getCurrentUser();
      final weekSchedule =
          await weekScheduleRepository.getWeeksSchedule(user.className!);

      final allEvents =
          weekSchedule.expand((week) => week.daySchedules).toList();

      initialDate ??= DateTime.now();

      final todayIndex = allEvents.indexWhere((daySchedule) =>
          daySchedule.date.day == initialDate!.day &&
          daySchedule.date.month == initialDate!.month &&
          daySchedule.date.year == initialDate!.year);

      emit(WeekScheduleLoaded(weekSchedule, todayIndex, allEvents, user));
    } catch (e) {
      emit(WeekScheduleError(e.toString()));
    }
  }

  void fetchUserAndSchedule() async {
    fetchWeekSchedule();
  }

  void updateTodayIndex(int index) {
    if (state is WeekScheduleLoaded) {
      emit((state as WeekScheduleLoaded).copyWith(todayIndex: index));
    }
  }

  void changeDate(DateTime newDate) {
    initialDate = newDate;
    emit(WeekScheduleDateChanged(newDate));
    fetchUserAndSchedule();
  }
}
