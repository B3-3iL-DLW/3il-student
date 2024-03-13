import 'package:flutter/material.dart';

class DatePickerButton extends StatelessWidget {
  const DatePickerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.calendar_month, color: Colors.white),
      onPressed: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (date != null) {
          // Utilisez la date sélectionnée
        }
      },
    );
  }
}
