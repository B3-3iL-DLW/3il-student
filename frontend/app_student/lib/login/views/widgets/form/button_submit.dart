import 'package:app_student/login/cubit/login_cubit.dart';
import 'package:app_student/utils/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SubmitButton extends StatelessWidget {
  final TextEditingController nameController;

  const SubmitButton({
    super.key,
    required this.nameController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
              backgroundColor:
                  MaterialStateProperty.all<Color>(CustomTheme.secondaryColor),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3.0),
                ),
              ),
            ),
            onPressed: () {
              final String name = nameController.text.trim();

              context.read<LoginCubit>().saveLoginDetails(name);
            },
            child: Text(
              AppLocalizations.of(context)!.loginButton,
            ),
          ),
        ),
      ],
    );
  }
}
