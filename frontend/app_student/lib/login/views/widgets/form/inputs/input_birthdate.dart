import 'package:app_student/utils/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BirthDateField extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<DateTime> onDateChanged;

  const BirthDateField({
    super.key,
    required this.controller,
    required this.onDateChanged,
  });

  @override
  BirthDateFieldState createState() => BirthDateFieldState();
}

class BirthDateFieldState extends State<BirthDateField> {
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        widget.controller.text =
            _selectedDate.toLocal().toString().split(' ')[0];
      });
      widget.onDateChanged(_selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.loginBirthDateLabel,
          style: CustomTheme.textSmall,
        ),
        TextFormField(
          controller: widget.controller,
          readOnly: true,
          decoration: InputDecoration(
            hintText: _selectedDate.toLocal().toString().split(' ')[0],
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: CustomTheme.primaryColor),
              borderRadius: BorderRadius.circular(3.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: CustomTheme.secondaryColor),
              borderRadius: BorderRadius.circular(3.0),
            ),
          ),
          onTap: () => _selectDate(context),
        ),
      ],
    );
  }
}
