import 'package:app_student/routes.dart';
import 'package:app_student/users/cubit/user_cubit.dart';
import 'package:app_student/utils/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class ClassGroupButton extends StatelessWidget {
  const ClassGroupButton({super.key});

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
              context.read<UserCubit>().clearUserClass();
              GoRouter.of(context).go(AppRoutes.classListPage);
            },
            child: Text(AppLocalizations.of(context)!.profilChangeClassButton,
                style: CustomTheme.textSmall.toColorWhite),
          ),
        ),
      ],
    );
  }
}
