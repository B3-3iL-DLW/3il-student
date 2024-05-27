import 'package:app_student/shared_components/network_error.dart';
import 'package:app_student/week_schedule/cubit/week_schedule_cubit.dart';
import 'package:app_student/week_schedule/views/widgets/datepicker_button.dart';
import 'package:app_student/week_schedule/views/widgets/day_schedule_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../menu/menu_view.dart';
import '../../shared_components/app_bar.dart';
import '../../utils/custom_layout.dart';

class WeekSchedulePage extends StatelessWidget {
  final DateTime? initialDate;

  const WeekSchedulePage({super.key, this.initialDate});

  @override
  Widget build(BuildContext context) {
    return CustomLayout(
      appBar: const CustomAppBar(widget: DatePickerButton()),
      body: BlocBuilder<WeekScheduleCubit, WeekScheduleState>(
        builder: (context, state) {
          final pageController = PageController(
            initialPage: state is WeekScheduleLoaded && state.todayIndex != -1
                ? state.todayIndex
                : 0,
          );
          if (state is WeekScheduleLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WeekScheduleLoaded) {
            final allEvents =
                state.weekSchedule.expand((week) => week.daySchedules).toList();

            return Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: PageView.builder(
                  controller: pageController,
                  itemCount: allEvents.length,
                  itemBuilder: (context, index) {
                    final daySchedule = allEvents[index];
                    return DayScheduleWidget(
                      daySchedule: daySchedule,
                      pageController: pageController,
                    );
                  },
                ),
              ),
            );
          } else if (state is WeekScheduleError) {
            return const NetworkError();
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
      bottomBar: const MenuBarView(),
    );
  }
}
