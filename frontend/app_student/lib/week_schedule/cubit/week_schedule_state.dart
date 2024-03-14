part of 'week_schedule_cubit.dart';

@immutable
abstract class WeekScheduleState {}

class WeekScheduleInitial extends WeekScheduleState {}

class WeekScheduleLoading extends WeekScheduleState {}

class WeekScheduleLoaded extends WeekScheduleState {
  final List<WeekScheduleModel> weekSchedule;
  final int todayIndex;
  final List<DayScheduleModel> allDaySchedules;

  WeekScheduleLoaded(this.weekSchedule, this.todayIndex, this.allDaySchedules);

  WeekScheduleLoaded copyWith({
    List<WeekScheduleModel>? weekSchedule,
    int? todayIndex,
    List<DayScheduleModel>? allDaySchedules,
  }) {
    return WeekScheduleLoaded(
      weekSchedule ?? this.weekSchedule,
      todayIndex ?? this.todayIndex,
      allDaySchedules ?? this.allDaySchedules,
    );
  }
}

class WeekScheduleDateChanged extends WeekScheduleState {
  final DateTime date;

  WeekScheduleDateChanged(this.date);
}

class WeekScheduleError extends WeekScheduleState {
  final String message;

  WeekScheduleError(this.message);
}
