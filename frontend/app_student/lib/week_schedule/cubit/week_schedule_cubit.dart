import 'package:app_student/api/day_schedule/models/day_schedule_model.dart';
import 'package:app_student/api/users/models/user_model.dart';
import 'package:app_student/api/week_schedule/models/week_schedule_model.dart';
import 'package:app_student/api/week_schedule/repositories/week_schedule_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../api/users/repositories/user_repository.dart';

part 'week_schedule_state.dart';

class WeekScheduleCubit extends Cubit<WeekScheduleState> {
  final WeekScheduleRepository weekScheduleRepository;
  final UserRepository userRepository;
  late DateTime? initialDate;

  WeekScheduleCubit(
      {required this.weekScheduleRepository,
      required this.userRepository,
      required this.initialDate})
      : super(WeekScheduleInitial());

  Future<UserModel> getUser() async {
    return await userRepository.getUser();
  }

  Future fetchWeekSchedule(String className) async {
    try {
      emit(WeekScheduleLoading());
      final weekSchedule =
          await weekScheduleRepository.getWeeksSchedule(className);

      final allEvents =
          weekSchedule.expand((week) => week.daySchedules).toList();

      initialDate ??= DateTime.now();

      final todayIndex = allEvents.indexWhere((daySchedule) =>
          daySchedule.date.day == initialDate!.day &&
          daySchedule.date.month == initialDate!.month &&
          daySchedule.date.year == initialDate!.year);

      emit(WeekScheduleLoaded(weekSchedule, todayIndex, allEvents));
    } catch (e) {
      emit(WeekScheduleError(e.toString()));
    }
  }

  void fetchUserAndSchedule() async {
    final user = await getUser();
    fetchWeekSchedule(user.className!);
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
