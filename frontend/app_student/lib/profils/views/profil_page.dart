import 'package:app_student/class_groups/views/widgets/header/header_text.dart';
import 'package:app_student/menu/menu_view.dart';
import 'package:app_student/profils/views/widgets/class_group_button.dart';
import 'package:flutter/material.dart';
import 'package:app_student/login/widgets/header/header_logo.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          const HeaderLogo(),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: HeaderText(
              AppLocalizations.of(context)!.profilMessageTitle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Card(
              child: ListTile(
                leading: SizedBox(
                  width: 50,
                  child: ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                        Color(0xFF005067), BlendMode.srcIn),
                    child: SvgPicture.asset(
                      'assets/images/user.svg',
                      width: 30,
                      height: 30,
                    ),
                  ),
                ),
                title: const Text('Classe'),
                subtitle: const Text('Nom du user'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Card(
              child: ListTile(
                leading: SizedBox(
                  width: 50,
                  child: ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                        Color(0xFF005067), BlendMode.srcIn),
                    child: SvgPicture.asset(
                      'assets/images/student-info.svg',
                      width: 30,
                      height: 30,
                    ),
                  ),
                ),
                title: const Text('ISBN'),
                subtitle: const Text('dd/mm/yyyy'),
              ),
            ),
          ),
          const ClassGroupButton(),
        ],
      ),
      bottomNavigationBar: const MenuBarView(),
    );
  }
}
