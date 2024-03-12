import 'package:app_student/api/day_schedule/entities/day_schedule_entity.dart';
import 'package:app_student/api/week_schedule/models/week_schedule_model.dart';
import 'package:app_student/api/week_schedule/repositories/week_schedule_repositories.dart';
import 'package:app_student/week_schedule/cubit/week_schedule_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DayScheduleWidget extends StatelessWidget {
  final DayScheduleEntity daySchedule;

  const DayScheduleWidget({Key? key, required this.daySchedule})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text('Date: ${daySchedule.date}'),
      children: daySchedule.events.map((event) {
        return ListTile(
          title: Text('Event: ${event.activite}'),
          subtitle: Text(
              'Start at: ${event.horaires.startAt}, End Time: ${event.horaires.endAt}'),
        );
      }).toList(),
    );
  }
}

class WeekScheduleWidget extends StatelessWidget {
  final WeekScheduleModel weekSchedule;

  const WeekScheduleWidget({Key? key, required this.weekSchedule})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text('Code: ${weekSchedule.code}'),
      children: weekSchedule.daySchedules.map((daySchedule) {
        return DayScheduleWidget(daySchedule: daySchedule);
      }).toList(),
    );
  }
}

class WeekSchedulePage extends StatelessWidget {
  const WeekSchedulePage({Key? key}) : super(key: key);

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
        appBar: AppBar(
          title: const Text('Week Schedule'),
        ),
        body: BlocBuilder<WeekScheduleCubit, WeekScheduleState>(
          builder: (context, state) {
            if (state is WeekScheduleLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is WeekScheduleLoaded) {
              return ListView.builder(
                itemCount: state.weekSchedule.length,
                itemBuilder: (context, index) {
                  final weekSchedule = state.weekSchedule[index];
                  return WeekScheduleWidget(weekSchedule: weekSchedule);
                },
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
