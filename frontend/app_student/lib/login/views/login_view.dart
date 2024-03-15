import 'package:app_student/login/views/widgets/form/form_login.dart';
import 'package:flutter/material.dart';

import '../../shared_components/header_logo.dart';
import '../../shared_components/header_title.dart';

class LoginView extends StatelessWidget {
  final String title;
  const LoginView(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const HeaderLogo(),
          HeaderTitle(title),
          const Expanded(child: FormLogin()),
        ],
      ),
    );
  }
}
