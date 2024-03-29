import 'package:app_student/api/events/models/event_model.dart';
import 'package:app_student/utils/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    super.key,
    required this.event,
  });

  final EventModel event;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: CustomTheme.primaryColor.withOpacity(0.5),
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            left: BorderSide(
              color: CustomTheme.primaryColor,
              width: 10.0,
            ),
          ),
        ),
        height: 110,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20.0, right: 20, bottom: 3, top: 3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: event.creneau == 3
                ? MainAxisAlignment.center
                : MainAxisAlignment.spaceEvenly,
            children: [
              Text(AppLocalizations.of(context)!.eventDuration,
                  style: CustomTheme.textSmall.toBold.toColorWhite),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      child: Text(event.activite,
                          style: CustomTheme.textXl.toBold)),
                  ColorFiltered(
                    colorFilter:
                        const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    child: SvgPicture.asset(
                      event.visio
                          ? 'assets/images/teams.svg'
                          : 'assets/images/school.svg',
                      width: 50,
                      height: 50,
                    ),
                  ),
                ],
              ),
              Flexible(
                child: Text(
                    '${AppLocalizations.of(context)!.roomLabel} ${event.salle}',
                    style: CustomTheme.text.toBold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
