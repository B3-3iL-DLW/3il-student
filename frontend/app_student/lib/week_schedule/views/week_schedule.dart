import 'package:app_student/api/week_schedule/repositories/week_schedule_repositories.dart';
import 'package:app_student/week_schedule/cubit/week_schedule_cubit.dart';
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
                  final WeekSchedule = state.weekSchedule[index];
                  return ListTile(
                    title: Text('Code: ${WeekSchedule.code}'),
                    // subtitle: Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: WeekSchedule.events.map((event) {
                    //     return Text(
                    //         'Event: ${event.activite}, Start at: ${event.horaires.startAt}, End Time: ${event.horaires.endAt}');
                    //   }).toList(),
                    // ),
                  );
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
