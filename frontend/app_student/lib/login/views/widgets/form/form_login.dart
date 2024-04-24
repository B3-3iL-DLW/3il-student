import 'package:flutter/material.dart';
import 'button_submit.dart';
import 'inputs/input_prenom.dart';

class FormLogin extends StatefulWidget {
  const FormLogin({super.key});

  @override
  FormLoginState createState() => FormLoginState();
}

class FormLoginState extends State<FormLogin> {
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 10.0),
        FirstnameTextField(controller: nameController),
        const SizedBox(height: 30.0),
        SubmitButton(
          nameController: nameController,
        ),
      ],
    );
  }
}
