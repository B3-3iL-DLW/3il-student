part of 'schedule_cubit.dart';

@immutable
abstract class ScheduleState {}

class ScheduleInitial extends ScheduleState {}

class ScheduleLoading extends ScheduleState {}

class ScheduleLoaded extends ScheduleState {
  final ScheduleModel schedule;

  ScheduleLoaded(this.schedule);
}
class ScheduleError extends ScheduleState {
  final String message;

  ScheduleError(this.message);
}
