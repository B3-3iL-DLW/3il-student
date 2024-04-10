import 'package:app_student/api/events/models/event_model.dart';
import 'package:app_student/utils/custom_theme.dart';
import 'package:flutter/material.dart';

import '../../../../utils/global.dart';

class EventHours extends StatelessWidget {
  const EventHours({
    super.key,
    required this.event,
  });

  final EventModel event;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Global.screenWidth * 0.15,
      child: Column(
        children: [
          SizedBox(
            child: Text(event.horaires.startAt,
                style: CustomTheme.textSmall.toBold),
          ),
          SizedBox(
            child:
                Text(event.horaires.endAt, style: CustomTheme.textSmall.toBold),
          ),
        ],
      ),
    );
  }
}
