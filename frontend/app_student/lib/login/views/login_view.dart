import 'package:app_student/utils/custom_layout.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../../shared_components/header_logo.dart';
import '../../shared_components/header_title.dart';
import '../../utils/global.dart';
import 'widgets/form/submit_button.dart';
import 'widgets/form/inputs/input_prenom.dart';

class LoginView extends StatelessWidget {
  final String title;
  final TextEditingController nameController = TextEditingController();

  LoginView(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return CustomLayout(
      appBar: HeaderLogo(appBarHeight: Global.screenHeight * 0.3),
      body: Column(
        children: [
          HeaderTitle(title),
          FormLogin(nameController: nameController),
        ],
      ),
      bottomContent: SubmitButton(nameController: nameController),
      bottomBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          AppLocalizations.of(context)!.termsAndPrivacy,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

class FormLogin extends StatelessWidget {
  final TextEditingController nameController;

  const FormLogin({required this.nameController, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 10.0),
        FirstnameTextField(controller: nameController),
        const SizedBox(height: 30.0),
      ],
    );
  }
}
