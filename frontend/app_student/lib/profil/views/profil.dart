import 'package:app_student/menu/menu_view.dart';
import 'package:app_student/profil/views/widgets/class_group_button.dart';
import 'package:app_student/profil/views/widgets/user_class_card.dart';
import 'package:app_student/routes.dart';
import 'package:app_student/utils/custom_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../shared_components/header_logo.dart';
import '../../shared_components/header_title.dart';
import '../../users/cubit/user_cubit.dart';
import '../../utils/global.dart';
import 'widgets/user_info_card.dart';

import 'package:app_student/menu/menu_view.dart';
import 'package:app_student/profil/views/widgets/class_group_button.dart';
import 'package:app_student/profil/views/widgets/user_class_card.dart';
import 'package:app_student/routes.dart';
import 'package:app_student/utils/custom_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../shared_components/header_logo.dart';
import '../../shared_components/header_title.dart';
import '../../users/cubit/user_cubit.dart';
import '../../utils/global.dart';
import 'widgets/user_info_card.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomLayout(
      appBar: HeaderLogo(appBarHeight: Global.screenHeight * 0.3),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          print(state);
          if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserPartialLoaded) {
            final user = state.user;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: HeaderTitle(
                    AppLocalizations.of(context)!
                        .profilMessageTitle(user.firstName ?? ''),
                  ),
                ),
                UserClassCard(
                    className: user.className ?? '-',
                    // Provide a default value if className is null
                    firstName: user.firstName ?? ''),
                const ClassGroupButton(),
              ],
            );
          } else if (state is UserLoaded) {
            final user = state.user;

            final birthDateString =
                DateFormat('dd/MM/yyyy').format(user.birthDate!);

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: HeaderTitle(
                    AppLocalizations.of(context)!
                        .profilMessageTitle(user.firstName),
                  ),
                ),
                UserClassCard(
                    className: user.className!, firstName: user.firstName),
                UserInfoCard(ine: user.ine!, birthDate: birthDateString),
                const ClassGroupButton(),
              ],
            );
          } else {
            return const SizedBox.shrink();
          }
        },
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
