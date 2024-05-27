import 'package:app_student/login/cubit/login_cubit.dart';
import 'package:app_student/login/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../users/cubit/user_cubit.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {},
      builder: (context, state) {
        return BlocBuilder<UserCubit, UserState>(
          builder: (context, userState) {
            if (state is RedirectToClassSelection) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.go('/classList');
              });
              return Container();
            } else if (state is LoginInitial) {
              return LoginView(AppLocalizations.of(context)!.loginWelcomeTitle);
            } else if (state is LoginAuthenticated) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.go('/schedule');
              });
              return Container();
            } else if (state is LoginFieldError) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content:
                        Text(AppLocalizations.of(context)!.loginFieldError),
                    backgroundColor: Colors.red,
                  ),
                );
              });
              return LoginView(
                  AppLocalizations.of(context)!.loginWelcomeTitleError);
            } else {
              return Container();
            }
          },
        );
      },
    );
  }
}
