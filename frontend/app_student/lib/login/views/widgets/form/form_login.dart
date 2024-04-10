import 'package:flutter/material.dart';
import 'button_submit.dart';
import 'inputs/input_prenom.dart';

class FormLogin extends StatefulWidget {
  const FormLogin({super.key});

  @override
  FormLoginState createState() => FormLoginState();
}

class FormLoginState extends State<FormLogin> {
  final TextEditingController ineController =
      TextEditingController(text: '999999999');
  final TextEditingController nameController = TextEditingController();
  final TextEditingController birthDateController =
      TextEditingController(text: '2000-01-01');
  DateTime birthDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: Stack(
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 10.0),
                    const SizedBox(height: 10.0),
                    // ceci est temporaire, le laisser tant qu'on ne remet pas les autres inputs
                    FirstnameTextField(controller: nameController),
                    const SizedBox(height: 10.0),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: SubmitButton(
                    ineController: ineController,
                    nameController: nameController,
                    birthDateController: birthDateController,
                    birthDate: birthDate,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
