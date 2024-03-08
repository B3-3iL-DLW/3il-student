import 'package:app_student/login/widgets/form/inputs/input_birthdate.dart';
import 'package:app_student/login/widgets/form/inputs/input_prenom.dart';
import 'package:app_student/login/widgets/header/header_text.dart';
import 'package:flutter/material.dart';

import '../widgets/form/inputs/input_ine.dart';
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
          INETextField(),
          BirthDateField(),
          FirstnameTextField()
          // TODO: Ajoutez le reste de votre contenu de page de connexion ici
        ],
      ),
    );
  }
}
