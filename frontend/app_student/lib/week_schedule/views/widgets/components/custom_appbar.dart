import 'package:app_student/week_schedule/views/widgets/components/datepicker_button.dart';
import 'package:flutter/material.dart';

class AppBarWeekSchedule extends StatelessWidget
    implements PreferredSizeWidget {
  const AppBarWeekSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF005067),
      leading: Image.asset('assets/images/3il-logo.jpg'),
      title: const Center(
          child: Text('Classe Name', style: TextStyle(color: Colors.white))),
      actions: const [
        DatePickerButton(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70.0);
}
