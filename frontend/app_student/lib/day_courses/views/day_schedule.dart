import 'package:flutter/material.dart';
import 'package:app_student/api/day_schedule/entities/day_schedule_entity.dart';

import '../bloc/day_course_bloc.dart';

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
                  title: Text(daySchedule.date.toString()),
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
