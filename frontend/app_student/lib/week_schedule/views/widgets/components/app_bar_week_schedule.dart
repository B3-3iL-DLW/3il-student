import 'package:app_student/api/users/repositories/user_repository.dart';
import 'package:app_student/users/cubit/user_cubit.dart';
import 'package:app_student/week_schedule/views/widgets/components/datepicker_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBarWeekSchedule extends StatelessWidget
    implements PreferredSizeWidget {
  const AppBarWeekSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    final userRepository = RepositoryProvider.of<UserRepository>(context);
    return AppBar(
      backgroundColor: const Color(0xFF005067),
      toolbarHeight: 70.0,
      title: Stack(
        alignment: Alignment.center,
        children: [
          Opacity(
            opacity: 0.5,
            child: Image.asset(
              'assets/images/3il-icon-white.png',
              fit: BoxFit.contain,
            ),
          ),
          Text(
            context.read()<UserCubit>().state.user?.name ?? '',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
        ],
      ),
      actions: const [
        DatePickerButton(),
      ],
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70.0);
}
