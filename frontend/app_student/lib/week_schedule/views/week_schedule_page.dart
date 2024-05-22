import 'package:app_student/api/week_schedule/repositories/week_schedule_repository.dart';
import 'package:app_student/shared_components/network_error.dart';
import 'package:app_student/users/cubit/user_cubit.dart';
import 'package:app_student/week_schedule/cubit/week_schedule_cubit.dart';
import 'package:app_student/week_schedule/views/widgets/datepicker_button.dart';
import 'package:app_student/week_schedule/views/widgets/day_schedule_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../api/users/repositories/user_repository.dart';
import '../../menu/menu_view.dart';
import '../../shared_components/app_bar.dart';
import '../../utils/custom_layout.dart';

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
            UserCubit(userRepository: userRepository)..fetchUser(),
        child: CustomLayout(
          appBar: const CustomAppBar(widget: DatePickerButton()),
          body: BlocBuilder<WeekScheduleCubit, WeekScheduleState>(
            builder: (context, state) {
              final pageController = PageController(
                initialPage:
                    state is WeekScheduleLoaded && state.todayIndex != -1
                        ? state.todayIndex
                        : 0,
              );
              if (state is WeekScheduleLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is WeekScheduleLoaded) {
                final allEvents = state.weekSchedule
                    .expand((week) => week.daySchedules)
                    .toList();

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
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Fluttertoast.showToast(
                    msg: state.message,
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    textColor: Colors.white,
                  );
                  print(state.message);
                });
                return const NetworkError();
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
          bottomBar: const MenuBarView(),
        ),
      ),
    );
  }
}
