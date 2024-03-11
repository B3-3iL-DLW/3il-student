part of 'day_schedule_cubit.dart';

@immutable
abstract class DayScheduleState {}

class DayScheduleInitial extends DayScheduleState {}

class DayScheduleLoading extends DayScheduleState {}

class DayScheduleLoaded extends DayScheduleState {
  final List daySchedule;

  DayScheduleLoaded(this.daySchedule);
}

class DayScheduleError extends DayScheduleState {
  final String message;

  DayScheduleError(this.message);
}