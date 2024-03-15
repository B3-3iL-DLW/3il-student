import 'package:app_student/components/header_title.dart';
import 'package:app_student/login/cubit/login_cubit.dart';
import 'package:app_student/login/widgets/form/form_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../components/header_logo.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        if (state is RedirectToClassSelection) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go('/classList');
          });
          return Container();
        } else if (state is LoginInitial) {
          return Scaffold(
            body: Column(
              children: [
                const HeaderLogo(),
                HeaderTitle(AppLocalizations.of(context)!.loginWelcomeTitle),
                const Expanded(child: FormLogin()),
              ],
            ),
          );
        } else if (state is LoginAuthenticated) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go('/schedule');
          });
          return Container();
        } else if (state is LoginFieldError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(AppLocalizations.of(context)!.loginFieldError),
                backgroundColor: Colors.red,
              ),
            );
          });
          return Scaffold(
            body: Column(
              children: [
                const HeaderLogo(),
                HeaderTitle(
                    AppLocalizations.of(context)!.loginWelcomeTitleError),
                const Expanded(child: FormLogin()),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
