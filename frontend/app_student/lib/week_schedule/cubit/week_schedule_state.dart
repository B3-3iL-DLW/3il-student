part of 'week_schedule_cubit.dart';

@immutable
abstract class WeekScheduleState {}

class WeekScheduleInitial extends WeekScheduleState {}

class WeekScheduleLoading extends WeekScheduleState {}

class WeekScheduleLoaded extends WeekScheduleState {
  final List<WeekScheduleModel> weekSchedule;
  final int todayIndex;
  final List<DayScheduleModel> allDaySchedules;
  final UserModel user; // Ajout du champ UserModel

  WeekScheduleLoaded(this.weekSchedule, this.todayIndex, this.allDaySchedules, this.user); // Ajout du UserModel au constructeur

  WeekScheduleLoaded copyWith({
    List<WeekScheduleModel>? weekSchedule,
    int? todayIndex,
    List<DayScheduleModel>? allDaySchedules,
    UserModel? user, // Ajout du UserModel à la méthode copyWith
  }) {
    return WeekScheduleLoaded(
      weekSchedule ?? this.weekSchedule,
      todayIndex ?? this.todayIndex,
      allDaySchedules ?? this.allDaySchedules,
      user ?? this.user, // Utilisation du UserModel dans la méthode copyWith
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