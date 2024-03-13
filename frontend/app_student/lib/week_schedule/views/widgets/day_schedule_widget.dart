import 'package:app_student/api/day_schedule/models/day_schedule_model.dart';
import 'package:flutter/material.dart';

class DayScheduleWidget extends StatelessWidget {
  final DayScheduleModel daySchedule;

  const DayScheduleWidget({super.key, required this.daySchedule});

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
