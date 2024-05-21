import 'package:app_student/shared_components/header_logo.dart';
import 'package:app_student/shared_components/header_title.dart';
import 'package:app_student/users/cubit/user_cubit.dart';
import 'package:app_student/utils/custom_button.dart';
import 'package:app_student/utils/custom_layout.dart';
import 'package:app_student/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LinkAccountForm extends StatelessWidget {
  final UserCubit userCubit;

  const LinkAccountForm({super.key, required this.userCubit});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    String ine = '050223219JD';
    String birthDate = '07/12/2002'; // Set your default birth date here
    final birthDateController = TextEditingController(text: birthDate);
    final ineController = TextEditingController(text: ine);

    return CustomLayout(
      appBar: HeaderLogo(appBarHeight: Global.screenHeight * 0.3),
      body: Column(
        children: [
          const HeaderTitle('Connexion'),
          Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: ineController,
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
                  controller: birthDateController,
                  decoration: InputDecoration(
                    labelText: 'Birth Date',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (pickedDate != null) {
                          birthDate =
                              DateFormat('dd/MM/yyyy').format(pickedDate);
                          birthDateController.text = birthDate;
                          formKey.currentState!.validate();
                        }
                      },
                    ),
                  ),
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
        ],
      ),
      bottomContent: CustomButton(
        text: 'Valider',
        onPressed: () {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            userCubit.loginAndSaveId(ine, birthDate);
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }
}
