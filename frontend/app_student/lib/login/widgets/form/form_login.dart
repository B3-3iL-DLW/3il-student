import 'package:flutter/material.dart';

import 'button_submit.dart';
import 'inputs/input_birthdate.dart';
import 'inputs/input_ine.dart';
import 'inputs/input_prenom.dart';

class FormLogin extends StatelessWidget {
  const FormLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          INETextField(),
          BirthDateField(),
          FirstnameTextField(),
          SubmitButton()
        ],
      ),
    );
  }
}
