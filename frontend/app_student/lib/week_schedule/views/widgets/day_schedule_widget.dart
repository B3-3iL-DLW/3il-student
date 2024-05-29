import 'package:app_student/api/day_schedule/models/day_schedule_model.dart';
import 'package:app_student/utils/custom_theme.dart';
import 'package:app_student/week_schedule/views/widgets/events/event_details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DayScheduleWidget extends StatelessWidget {
  final DayScheduleModel daySchedule;
  final PageController pageController;

  const DayScheduleWidget(
      {super.key, required this.daySchedule, required this.pageController});

  @override
  Widget build(BuildContext context) {
    final Locale locale = Localizations.localeOf(context);
    final DateFormat formatter = DateFormat.yMMMMd(locale.toString());
    final String formattedDate = formatter.format(daySchedule.date);
    final String capitalizedDate = formattedDate[0].toUpperCase() + formattedDate.substring(1);

    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    pageController.previousPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 25, left: 25),
                  child: Text(
                    capitalizedDate,
                    style: CustomTheme.subtitle.toBold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: () {
                    pageController.nextPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ...daySchedule.events.map((event) {
            return EventDetails(event: event);
          }),
        ],
      ),
    );
  }
}