import 'package:app_student/day_schedules/bloc/day_schedule_bloc.dart';
import 'package:flutter/material.dart';
import 'package:app_student/api/day_schedule/entities/day_schedule.dart';

class DayScheduleView extends StatelessWidget {
  final DayScheduleBloc dayScheduleBloc;

  const DayScheduleView({super.key, required this.dayScheduleBloc});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<DaySchedule>>(
      stream: dayScheduleBloc.dayScheduleStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final daySchedule = snapshot.data![index];
              return Card(
                child: ListTile(
                  title: Text(daySchedule.date),
                  subtitle: Text('Jour: ${daySchedule.jour}'),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('Erreur: ${snapshot.error}');
        }

        return const Text('Erreur: Les données ne sont pas encore disponibles');
      },
    );
  }
}
