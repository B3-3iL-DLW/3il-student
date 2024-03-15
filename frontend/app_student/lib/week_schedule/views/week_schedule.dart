import 'package:app_student/api/week_schedule/repositories/week_schedule_repository.dart';
import 'package:app_student/menu/menu_view.dart';
import 'package:app_student/users/cubit/user_cubit.dart';
import 'package:app_student/week_schedule/cubit/week_schedule_cubit.dart';
import 'package:app_student/week_schedule/views/widgets/day_schedule_widget.dart';
import 'package:app_student/week_schedule/views/widgets/components/app_bar_week_schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/users/repositories/user_repository.dart';

class WeekSchedulePage extends StatelessWidget {
  final DateTime? initialDate;

  const WeekSchedulePage({super.key, this.initialDate});

  @override
  Widget build(BuildContext context) {
    final weekScheduleRepository =
    RepositoryProvider.of<WeekScheduleRepository>(context);
    final userRepository = RepositoryProvider.of<UserRepository>(context);
    final weekScheduleCubit = WeekScheduleCubit(
        userCubit: context.read<UserCubit>(),
        weekScheduleRepository: weekScheduleRepository,
        initialDate: initialDate);

    return BlocProvider<WeekScheduleCubit>(
      create: (context) => weekScheduleCubit..fetchUserAndSchedule(),
      child: BlocProvider<UserCubit>(
        create: (context) =>
        UserCubit(userRepository: userRepository)
          ..fetchUser(),
        child: Scaffold(
          appBar: const AppBarWeekSchedule(),
          body: BlocBuilder<WeekScheduleCubit, WeekScheduleState>(
            builder: (context, state) {
              if (state is WeekScheduleLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is WeekScheduleLoaded) {
                final allEvents = state.weekSchedule
                    .expand((week) => week.daySchedules)
                    .toList();

                return Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: SizedBox(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height,
                    child: PageView.builder(
                      controller: PageController(
                        initialPage:
                        state.todayIndex != -1 ? state.todayIndex : 0,
                      ),
                      itemCount: allEvents.length,
                      itemBuilder: (context, index) {
                        final daySchedule = allEvents[index];
                        return DayScheduleWidget(daySchedule: daySchedule);
                      },
                    ),
                  ),
                );
              } else if (state is WeekScheduleError) {
                return Center(child: Text(state.message));
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
          bottomNavigationBar: const MenuBarView(),
        ),
      ),
    );
  }
}
