import 'package:app_student/login/widgets/form/form_login.dart';
import 'package:app_student/login/widgets/header/header_text.dart';
import 'package:flutter/material.dart';

import '../widgets/header/header_logo.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          HeaderLogo(),
          HeaderText("Bonjour :)"),
          Expanded(child: FormLogin()),
        ],
      ),
    );
  }
}
