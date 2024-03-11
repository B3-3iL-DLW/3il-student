import 'package:app_student/api/schedule/repositories/schedule_repository.dart';
import 'package:app_student/schedule/cubit/schedule_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    final scheduleRepository =
        RepositoryProvider.of<ScheduleRepository>(context);
    final scheduleCubit = ScheduleCubit(scheduleRepository: scheduleRepository);

    return BlocProvider<ScheduleCubit>(
      create: (context) => scheduleCubit..fetchSchedule('B3 Groupe 3 DLW-FA'),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Schedule'),
        ),
        body: BlocBuilder<ScheduleCubit, ScheduleState>(
          builder: (context, state) {
            if (state is ScheduleLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ScheduleLoaded) {
              return ListView.builder(
                itemCount: state.schedule.weekSchedules.length,
                itemBuilder: (context, index) {
                  return ExpansionTile(
                    title: Text('Week ${state.schedule.weekSchedules[index].code}'),
                    children: state.schedule.weekSchedules[index].daySchedules.map((day) {
                      return ExpansionTile(
                        title: Text('Day ${day.jour}'),
                        children: day.events.map((event) {
                          return ListTile(
                            title: Text(event.activite),
                            subtitle: Text(
                                'From ${event.horaires.startAt} to ${event.horaires.endAt}'),
                            trailing: Text(event.salle),
                          );
                        }).toList(),
                      );
                    }).toList(),
                  );
                },
              );
            } else if (state is ScheduleError) {
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
