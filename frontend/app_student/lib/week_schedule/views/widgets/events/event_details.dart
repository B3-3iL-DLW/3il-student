import 'package:app_student/api/events/models/event_model.dart';
import 'package:app_student/utils/global.dart';
import 'package:app_student/week_schedule/views/widgets/events/event_hours.dart';
import 'package:app_student/week_schedule/views/widgets/events/event_info.dart';
import 'package:flutter/material.dart';

class EventDetails extends StatelessWidget {
  final EventModel event;

  const EventDetails({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            EventHours(event: event),
            SizedBox(
              width: Global.screenWidth * 0.75,
              child: EventInfo(event: event),
            ),
          ],
        );
      },
    );
  }
}
