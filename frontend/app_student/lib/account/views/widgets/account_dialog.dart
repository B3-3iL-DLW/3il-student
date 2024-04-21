import 'package:app_student/account/account_cubit.dart';
import 'package:flutter/material.dart';

class AccountDialog extends StatelessWidget {
  final AccountCubit accountCubit;

  const AccountDialog({super.key, required this.accountCubit});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    String ine = '';
    String birthDate = '';

    return AlertDialog(
      title: const Text('Login'),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
          ],
        ),
      ),
      actions: [
        TextButton(
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
    );
  }
}