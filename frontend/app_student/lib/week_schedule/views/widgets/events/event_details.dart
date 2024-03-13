import 'package:app_student/api/events/models/event_model.dart';
import 'package:app_student/week_schedule/views/widgets/events/event_card.dart';
import 'package:app_student/week_schedule/views/widgets/events/event_hours.dart';
import 'package:flutter/material.dart';

class EventDetails extends StatelessWidget {
  final EventModel event;

  const EventDetails({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        EventHours(event: event),
        EventCard(event: event),
      ],
    );
  }
}
