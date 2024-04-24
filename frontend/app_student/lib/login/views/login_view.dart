import 'package:app_student/login/views/widgets/form/form_login.dart';
import 'package:app_student/utils/custom_layout.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../../shared_components/header_logo.dart';
import '../../shared_components/header_title.dart';
import '../../utils/global.dart';

class LoginView extends StatelessWidget {
  final String title;

  const LoginView(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return CustomLayout(
      appBar: HeaderLogo(appBarHeight: Global.screenHeight * 0.3),
      body: Column(
        children: [
          HeaderTitle(title),
          FormLogin(),
        ],
      ),
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
