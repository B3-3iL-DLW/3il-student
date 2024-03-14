import 'package:app_student/api/day_schedule/models/day_schedule_model.dart';
import 'package:app_student/week_schedule/views/widgets/events/event_details.dart';
import 'package:flutter/material.dart';

class DayScheduleWidget extends StatelessWidget {
  final DayScheduleModel daySchedule;

  const DayScheduleWidget({super.key, required this.daySchedule});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: daySchedule.events.map((event) {
          return EventDetails(event: event);
        }).toList(),
      ),
    );
  }
}
