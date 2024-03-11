import 'package:app_student/api/day_schedule/repositories/day_schedule.dart';
import 'package:app_student/day_schedule/cubit/day_schedule_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DaySchedulePage extends StatelessWidget {
  const DaySchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    final dayScheduleRepository =
    RepositoryProvider.of<DayScheduleRepository>(context);
    final dayScheduleCubit = DayScheduleCubit(dayScheduleRepository: dayScheduleRepository);

    return BlocProvider<DayScheduleCubit>(
      create: (context) => dayScheduleCubit..fetchDaySchedule('B3 Groupe 3 DLW-FA'),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Day Schedule'),
        ),
        body: BlocBuilder<DayScheduleCubit, DayScheduleState>(
          builder: (context, state) {
            if (state is DayScheduleLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is DayScheduleLoaded) {
              return ListView.builder(
                itemCount: state.daySchedule.length,
                itemBuilder: (context, index) {
                  final daySchedule = state.daySchedule[index];
                  return ListTile(
                    title: Text('Date: ${daySchedule.date}, Jour: ${daySchedule.jour}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: daySchedule.events.map((event) {
                        return Text('Event: ${event.activite}, Start at: ${event.horaires.startAt}, End Time: ${event.horaires.endAt}');
                      }).toList(),
                    ),
                  );
                },
              );
            } else if (state is DayScheduleError) {
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
