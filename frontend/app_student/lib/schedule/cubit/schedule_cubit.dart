import 'package:app_student/api/schedule/models/schedule_model.dart';
import 'package:app_student/api/schedule/repositories/schedule_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'schedule_state.dart';

class ScheduleCubit extends Cubit<ScheduleState> {
  final ScheduleRepository scheduleRepository;

  ScheduleCubit({required this.scheduleRepository}) : super(ScheduleInitial());

  Future fetchSchedule(String className) async {
    try {
      print(scheduleRepository.getSchedule(className));
      emit(ScheduleLoading());
      final schedule = await scheduleRepository.getSchedule(className);
      emit(ScheduleLoaded(schedule));
    } catch (e) {
      emit(ScheduleError(e.toString()));
    }
  }
}
