import 'package:app_student/api/day_schedule/models/day_schedule_model.dart';
import 'package:app_student/utils/custom_theme.dart';
import 'package:app_student/week_schedule/views/widgets/events/event_details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DayScheduleWidget extends StatelessWidget {
  final DayScheduleModel daySchedule;

  const DayScheduleWidget({super.key, required this.daySchedule});

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('EEEE dd MMMM yyyy', 'fr_FR').format(daySchedule.date);
    String capitalizedDate =
        formattedDate[0].toUpperCase() + formattedDate.substring(1);
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Text(
              capitalizedDate,
              style: CustomTheme.subtitle.toBold,
            ),
          ),
          const SizedBox(height: 30),
          ...daySchedule.events.map((event) {
            return EventDetails(event: event);
          }),
        ],
      ),
    );
  }
}
