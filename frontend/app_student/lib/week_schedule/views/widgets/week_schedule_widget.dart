import 'package:app_student/api/week_schedule/models/week_schedule_model.dart';
import 'package:app_student/week_schedule/views/widgets/day_schedule_widget.dart';
import 'package:flutter/material.dart';

class WeekScheduleWidget extends StatelessWidget {
  final WeekScheduleModel weekSchedule;

  const WeekScheduleWidget({super.key, required this.weekSchedule});

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
