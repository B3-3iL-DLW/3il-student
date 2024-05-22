import 'dart:async';
import 'dart:io';

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
      if (isClosed) {
        return;
      }
      emit(WeekScheduleLoading());
      final user = await userCubit.getCurrentUser();
      final weekSchedule =
          await weekScheduleRepository.getWeeksSchedule(user.className!);

      final allEvents =
          weekSchedule.expand((week) => week.daySchedules).toList();

      // Only find the closest date if initialDate has not been set
      initialDate ??= findClosestDate(allEvents);

      final todayIndex = findTodayIndex(allEvents);

      if (isClosed) {
        return;
      }
      emit(WeekScheduleLoaded(weekSchedule, todayIndex, allEvents, user));
    } on HttpException catch (he) {
      if (isClosed) {
        return;
      }
      emit(WeekScheduleError(he.message));
    } on SocketException catch (se) {
      if (isClosed) {
        return;
      }
      emit(WeekScheduleError(se.message));
    } on FormatException catch (fe) {
      if (isClosed) {
        return;
      }
      emit(WeekScheduleError(fe.message));
    } catch (e) {
      if (isClosed) {
        return;
      }
      emit(WeekScheduleError(e.toString()));
    }
  }

  DateTime findClosestDate(List<DayScheduleModel> daySchedules) {
    DateTime currentDate = DateTime.now();
    currentDate =
        DateTime(currentDate.year, currentDate.month, currentDate.day);

    for (var day in daySchedules) {
      DateTime dayDate = DateTime(day.date.year, day.date.month, day.date.day);
      if (dayDate == currentDate) {
        currentDate = dayDate;
        return currentDate;
      } else {
        try {
          var nextDayWithEvent = daySchedules.firstWhere(
              (daySchedule) => daySchedule.date.isAfter(currentDate));
          currentDate = nextDayWithEvent.date;
          return currentDate;
        } catch (e) {
          // No next day with an event found, continue to the next day
          continue;
        }
      }
    }

    return currentDate;
  }

  int findTodayIndex(List<DayScheduleModel> allEvents) {
    return allEvents.indexWhere((daySchedule) =>
        daySchedule.date.day == initialDate!.day &&
        daySchedule.date.month == initialDate!.month &&
        daySchedule.date.year == initialDate!.year);
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

  void changeToNextOrPreviousDate(bool isNext) {
    if (state is WeekScheduleLoaded) {
      final currentIndex = (state as WeekScheduleLoaded).todayIndex;
      final allDaySchedules = (state as WeekScheduleLoaded).allDaySchedules;
      if (isNext && currentIndex < allDaySchedules.length - 1) {
        changeDate(allDaySchedules[currentIndex + 1].date);
      } else if (!isNext && currentIndex > 0) {
        changeDate(allDaySchedules[currentIndex - 1].date);
      }
    }
  }
}
