import 'package:app_student/api/week_schedule/repositories/week_schedule_repository.dart';
import 'package:app_student/week_schedule/cubit/week_schedule_cubit.dart';
import 'package:app_student/week_schedule/views/widgets/day_schedule_widget.dart';
import 'package:app_student/week_schedule/views/widgets/components/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeekSchedulePage extends StatelessWidget {
  const WeekSchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    final weekScheduleRepository =
    RepositoryProvider.of<WeekScheduleRepository>(context);
    final weekScheduleCubit =
    WeekScheduleCubit(weekScheduleRepository: weekScheduleRepository);

    return BlocProvider<WeekScheduleCubit>(
      create: (context) =>
      weekScheduleCubit..fetchWeekSchedule('B3 Groupe 3 DLW-FA'),
      child: Scaffold(
        appBar: const AppBarWeekSchedule(),
        body: BlocBuilder<WeekScheduleCubit, WeekScheduleState>(
          builder: (context, state) {
            if (state is WeekScheduleLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is WeekScheduleLoaded) {
              return Padding(
                padding: const EdgeInsets.only(top: 30.0), // Ajoutez un espacement en haut
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: PageView.builder(
                    itemCount: state.weekSchedule.length, // Nombre de semaines
                    itemBuilder: (context, weekIndex) {
                      final week = state.weekSchedule[weekIndex];
                      return PageView.builder(
                        itemCount: week.daySchedules.length, // Nombre de jours dans la semaine
                        itemBuilder: (context, dayIndex) {
                          final daySchedule = week.daySchedules[dayIndex];
                          return DayScheduleWidget(daySchedule: daySchedule);
                        },
                      );
                    },
                  ),
                ),
              );
            } else if (state is WeekScheduleError) {
              return Center(child: Text(state.message));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}