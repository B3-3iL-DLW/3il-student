import 'package:app_student/api/week_schedule/repositories/week_schedule_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../api/users/repositories/user_repository.dart';

part 'week_schedule_state.dart';

class WeekScheduleCubit extends Cubit<WeekScheduleState> {
  final WeekScheduleRepository weekScheduleRepository;
  final UserRepository userRepository;

  WeekScheduleCubit(
      {required this.weekScheduleRepository, required this.userRepository})
      : super(WeekScheduleInitial());

  Future getUser() async {
    return await userRepository.getUser();
  }

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

  void fetchUserAndSchedule() async {
    final user = await getUser();
    fetchWeekSchedule(user.className);
  }
}
