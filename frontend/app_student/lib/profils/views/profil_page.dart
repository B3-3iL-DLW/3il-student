import 'package:app_student/class_groups/views/widgets/header/header_text.dart';
import 'package:app_student/menu/menu_view.dart';
import 'package:app_student/profils/views/widgets/class_group_button.dart';
import 'package:app_student/profils/views/widgets/user_class_card.dart';
import 'package:app_student/profils/views/widgets/user_info_card.dart';
import 'package:flutter/material.dart';
import 'package:app_student/login/widgets/header/header_logo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              AppLocalizations.of(context)!.profilMessageTitle(firstName),
            ),
          ),
          UserClassCard(className: className, firstName: firstName),
          UserInfoCard(ine: ine, birthDate: birthDateString),
          const ClassGroupButton(),
        ],
      ),
      bottomNavigationBar: const MenuBarView(),
    );
  }
}
