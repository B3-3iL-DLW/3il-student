import 'package:app_student/api/events/models/event_model.dart';
import 'package:app_student/utils/custom_theme.dart';
import 'package:flutter/material.dart';

class EventHours extends StatelessWidget {
  const EventHours({
    super.key,
    required this.event,
  });

  final EventModel event;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: Column(
        children: [
          Text(event.horaires.startAt, style: CustomTheme.text.toBold),
          Text(event.horaires.endAt, style: CustomTheme.text.toBold),
        ],
      ),
    );
  }
}
