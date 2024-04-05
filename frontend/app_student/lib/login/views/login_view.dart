import 'package:app_student/login/views/widgets/form/form_login.dart';
import 'package:flutter/material.dart';

import '../../shared_components/header_logo.dart';
import '../../shared_components/header_title.dart';
import '../../utils/global.dart';

class LoginView extends StatelessWidget {
  final String title;
  const LoginView(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HeaderLogo(appBarHeight: Global.screenHeight * 0.3),
          HeaderTitle(title),
          const Expanded(child: FormLogin()),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'En utilisant le service, vous acceptez nos conditions d\'utilisation et notre politique de confidentialité.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
