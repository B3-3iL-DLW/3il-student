import 'package:app_student/users/cubit/user_cubit.dart';
import 'package:app_student/week_schedule/views/widgets/components/datepicker_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBarWeekSchedule extends StatelessWidget
    implements PreferredSizeWidget {
  const AppBarWeekSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    final userState = context.watch<UserCubit>().state;
    String className = '';
    if (userState is UserLoaded) {
      className = userState.user.entity.className ?? '';
    }
    return AppBar(
      backgroundColor: const Color(0xFF005067),
      title: const SizedBox.shrink(), // Make the title empty
      flexibleSpace: Stack(
        alignment: Alignment.center,
        children: [
          ClipRect(
            child: Center(
              child: Opacity(
                opacity: 0.5,
                child: Transform.scale(
                  scale: 3.0, // Adjust the scale factor to zoom the image
                  child: Image.asset(
                    'assets/images/3il-icon-white.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Text(
            className,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Positioned(
            right: 0,
            child: DatePickerButton(),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70.0);
}
