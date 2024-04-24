import 'package:app_student/account/account_cubit.dart';
import 'package:app_student/shared_components/header_logo.dart';
import 'package:app_student/utils/custom_layout.dart';
import 'package:app_student/utils/global.dart';
import 'package:flutter/material.dart';

class LoginFormPage extends StatelessWidget {
  final AccountCubit accountCubit;

  const LoginFormPage({super.key, required this.accountCubit});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    String ine = '';
    String birthDate = '';

    return CustomLayout(
      appBar: HeaderLogo(appBarHeight: Global.screenHeight * 0.3),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'INE'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your INE';
                  }
                  return null;
                },
                onSaved: (value) {
                  ine = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Birth Date'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your birth date';
                  }
                  return null;
                },
                onSaved: (value) {
                  birthDate = value!;
                },
              ),
              ElevatedButton(
                child: const Text('Submit'),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    accountCubit.loginAndSaveId(ine, birthDate);
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          ),
        ),
      ),
      // Add your bottomBar here if you have one
      // bottomBar: YourBottomBar(),
    );
  }
}
