import 'package:app_student/utils/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FirstnameTextField extends StatelessWidget {
  final TextEditingController controller;

  const FirstnameTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.loginFirstNameLabel,
          style: CustomTheme.textSmall,
        ),
        TextFormField(
          controller: controller,
          style: CustomTheme.text,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.loginFirstNameHint,
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
        ),
      ],
    );
  }
}
