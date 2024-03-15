import 'package:app_student/class_groups/views/widgets/header/header_text.dart';
import 'package:app_student/menu/menu_view.dart';
import 'package:app_student/profils/views/widgets/class_group_button.dart';
import 'package:flutter/material.dart';
import 'package:app_student/login/widgets/header/header_logo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../users/cubit/user_cubit.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userState = context.watch<UserCubit>().state;
    String firstName = '';
    String className = '';
    String ine = '';
    DateTime? birthDate;

    if (userState is UserLoaded) {
      firstName = userState.user.entity.firstName;
      className = userState.user.entity.className!;
      ine = userState.user.entity.ine;
      birthDate = userState.user.entity.birthDate;
    }

    String birthDateString = birthDate != null
        ? DateFormat('dd/MM/yyyy').format(birthDate)
        : 'error';

    return Scaffold(
      body: Column(
        children: <Widget>[
          const HeaderLogo(),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: HeaderText(
              '${AppLocalizations.of(context)!.profilMessageTitle} $firstName',
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
                title: Text(className),
                subtitle: Text(firstName),
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
                title: Text(ine),
                subtitle: Text(birthDateString),
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
