part of 'week_schedule_cubit.dart';

@immutable
abstract class WeekScheduleState {}

class WeekScheduleInitial extends WeekScheduleState {}

class WeekScheduleLoading extends WeekScheduleState {}

class WeekScheduleLoaded extends WeekScheduleState {
  final List weekSchedule;

  WeekScheduleLoaded(this.weekSchedule);
}

class WeekScheduleError extends WeekScheduleState {
  final String message;

  WeekScheduleError(this.message);
}
