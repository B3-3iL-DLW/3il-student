import 'package:app_student/api/api_service.dart';
import 'package:app_student/api/class_groups/repositories/class_group_repository.dart';
import 'package:app_student/config/config.dart';
import 'package:app_student/login/cubit/login_cubit.dart';
import 'package:app_student/login/widgets/form/form_login.dart';
import 'package:app_student/login/widgets/header/header_text.dart';
import 'package:app_student/week_schedule/views/week_schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../class_groups/cubit/class_group_cubit.dart';
import '../../class_groups/views/class_group_view.dart';
import '../widgets/header/header_logo.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        if (state is RedirectToClassSelection) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final config = Provider.of<Config>(context, listen: false);
            Navigator.of(context).pushReplacement(
              MaterialPageRoute<ClassListPage>(
                builder: (context) => BlocProvider(
                    create: (_) => ClassGroupCubit(
                        classRepository: ClassGroupRepository(
                            apiService: ApiService(apiUrl: config.apiUrl))),
                    child: const ClassListPage()),
              ),
            );
          });
          return Container();
        } else if (state is LoginInitial) {
          return const Scaffold(
            body: Column(
              children: [
                HeaderLogo(),
                HeaderText('Bonjour :)'),
                Expanded(child: FormLogin()),
              ],
            ),
          );
        } else if (state is LoginAuthenticated) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const WeekSchedulePage()),
            );
          });
          return Container();
        } else if (state is LoginFieldError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Veuillez remplir tous les champs"),
                backgroundColor: Colors.red,
              ),
            );
          });
          return const Scaffold(
            body: Column(
              children: [
                HeaderLogo(),
                HeaderText('Bonjour :)'),
                Expanded(child: FormLogin()),
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
