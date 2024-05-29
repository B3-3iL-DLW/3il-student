import 'package:app_student/shared_components/header_logo.dart';
import 'package:app_student/shared_components/header_title.dart';
import 'package:app_student/users/cubit/user_cubit.dart';
import 'package:app_student/utils/custom_button.dart';
import 'package:app_student/utils/custom_layout.dart';
import 'package:app_student/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class LinkAccountForm extends StatelessWidget {
  const LinkAccountForm({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final formKey = GlobalKey<FormState>();
    String ine = '';
    String birthDate = '';
    final birthDateController = TextEditingController(text: birthDate);
    final ineController = TextEditingController(text: ine);

    return CustomLayout(
      appBar: HeaderLogo(appBarHeight: Global.screenHeight * 0.3),
      body: Column(
        children: [
          HeaderTitle(localizations.loginButton),
          Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: ineController,
                  decoration: InputDecoration(labelText: localizations.ineLabel),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return localizations.ineError;
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
                    labelText: localizations.birthDateLabel,
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
                      return localizations.birthDateError;
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
        text: localizations.validateButton,
        onPressed: () {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            context.read<UserCubit>().loginAndSaveId(ine, birthDate);
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }
}