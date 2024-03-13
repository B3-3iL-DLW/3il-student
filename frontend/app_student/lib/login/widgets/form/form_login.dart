import 'package:flutter/material.dart';

import 'button_submit.dart';
import 'inputs/input_birthdate.dart';
import 'inputs/input_ine.dart';
import 'inputs/input_prenom.dart';

class FormLogin extends StatefulWidget {
  const FormLogin({super.key});

  @override
  FormLoginState createState() => FormLoginState();
}

class FormLoginState extends State<FormLogin> {
  final TextEditingController ineController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            INETextField(controller: ineController),
            BirthDateField(controller: birthDateController),
            FirstnameTextField(controller: nameController),
            SubmitButton(
              ineController: ineController,
              nameController: nameController,
              birthDateController: birthDateController,
            )
          ],
        ),
      ),
    );
  }
}
