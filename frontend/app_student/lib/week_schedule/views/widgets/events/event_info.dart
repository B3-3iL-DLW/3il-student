import 'package:app_student/api/events/models/event_model.dart';
import 'package:flutter/material.dart';

import '../../../../utils/custom_theme.dart';
import 'event_card.dart';
import 'event_empty_card.dart';
import 'event_meal_card.dart';

class EventInfo extends StatelessWidget {
  const EventInfo({
    super.key,
    required this.event,
  });

  final EventModel event;

  @override
  Widget build(BuildContext context) {
    if (event.activite == 'Pas cours' && event.creneau != 3) {
      return const EventEmptyCard();
    }
    return event.repas == true
        ? const EventMealCard()
        : EventCard(
            event: event,
            cardColor: event.eval
                ? CustomTheme.secondaryColor
                : CustomTheme.primaryColorLight,
            borderColor: event.eval
                ? CustomTheme.secondaryColor
                : CustomTheme.primaryColor,
          );
  }
}
