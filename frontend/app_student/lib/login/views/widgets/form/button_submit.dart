import 'package:app_student/login/cubit/login_cubit.dart';
import 'package:app_student/utils/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SubmitButton extends StatelessWidget {
  final TextEditingController ineController;
  final TextEditingController nameController;
  final TextEditingController birthDateController;
  final DateTime birthDate;

  const SubmitButton(
      {super.key,
      required this.ineController,
      required this.nameController,
      required this.birthDateController,
      required this.birthDate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, top: 80.0, right: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            height: 50.0,
            child: ElevatedButton(
              style: ButtonStyle(
                textStyle: MaterialStateProperty.all<TextStyle>(
                  CustomTheme.text.toBold,
                ),
                backgroundColor: MaterialStateProperty.all<Color>(
                    CustomTheme.secondaryColor),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                ),
              ),
              onPressed: () {
                final String ine = ineController.text.trim();
                final String name = nameController.text.trim();
                final String birthDate = birthDateController.text.trim();

                context
                    .read<LoginCubit>()
                    .saveLoginDetails(ine, name, birthDate);
              },
              child: Text(
                AppLocalizations.of(context)!.loginButton,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
