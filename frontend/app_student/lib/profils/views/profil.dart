import 'package:app_student/menu/menu_view.dart';
import 'package:app_student/profils/views/widgets/class_group_button.dart';
import 'package:app_student/profils/views/widgets/user_class_card.dart';
import 'package:app_student/routes.dart';
import 'package:app_student/utils/custom_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../../shared_components/header_logo.dart';
import '../../shared_components/header_title.dart';
import '../../users/cubit/user_cubit.dart';
import '../../utils/global.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userState = context.watch<UserCubit>().state;
    String firstName = '';
    String className = '';
    // String ine = '';
    // DateTime? birthDate;

    if (userState is UserLoaded) {
      firstName = userState.user.entity.firstName;
      className = userState.user.entity.className!;
      // ine = userState.user.entity.ine;
      // birthDate = userState.user.entity.birthDate;
    }

    // String birthDateString = birthDate != null
    //     ? DateFormat('dd/MM/yyyy').format(birthDate)
    //     : 'error';

    return CustomLayout(
      appBar: HeaderLogo(appBarHeight: Global.screenHeight * 0.3),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: HeaderTitle(
              AppLocalizations.of(context)!.profilMessageTitle(firstName),
            ),
          ),
          UserClassCard(className: className, firstName: firstName),
          // UserInfoCard(ine: ine, birthDate: birthDateString),
          const ClassGroupButton(),
        ],
      ),
      bottomContent: ElevatedButton(
          onPressed: () {
            context.read<UserCubit>().deleteUser();
            GoRouter.of(context).go(AppRoutes.loginPage);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Fluttertoast.showToast(
                msg: AppLocalizations.of(context)!.disconnectedMessage,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                textColor: Colors.white,
              );
            });
          },
          child: Text(AppLocalizations.of(context)!.disconnect)),
      bottomBar: const MenuBarView(),
    );
  }
}
