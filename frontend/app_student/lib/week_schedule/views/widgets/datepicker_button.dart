import 'package:app_student/week_schedule/cubit/week_schedule_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DatePickerButton extends StatelessWidget {
  const DatePickerButton({super.key});

  Future<void> navigateToDate(
      BuildContext context, WeekScheduleCubit cubit, DateTime date) async {
    final index = (cubit.state as WeekScheduleLoaded)
        .allDaySchedules
        .indexWhere((event) =>
            DateTime(event.date.year, event.date.month, event.date.day) ==
            DateTime(date.year, date.month, date.day));
    if (index != -1) {
      cubit.changeDate(date);
      context.go('/schedule'); // Replace with the appropriate navigation logic
    }
  }

  Future<DateTime?> selectDate(
      BuildContext context, WeekScheduleCubit cubit) async {
    return await showDatePicker(
      context: context,
      initialDate: cubit.initialDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      selectableDayPredicate: (date) {
        return cubit.state is WeekScheduleLoaded &&
            (cubit.state as WeekScheduleLoaded).allDaySchedules.any((event) =>
                DateTime(event.date.year, event.date.month, event.date.day) ==
                DateTime(date.year, date.month, date.day));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<WeekScheduleCubit>();
    return IconButton(
      icon: const Icon(
        Icons.calendar_month,
        color: Colors.white,
        size: 30,
      ),
      onPressed: () async {
        final date = await selectDate(context, cubit);
        if (date != null) {
          if (context.mounted) {
            await navigateToDate(context, cubit, date); // Await the navigation
          }
        }
      },
    );
  }
}
