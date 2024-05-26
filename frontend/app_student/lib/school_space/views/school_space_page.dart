import 'package:app_student/users/cubit/user_cubit.dart';
import 'package:app_student/utils/custom_button.dart';
import 'package:app_student/utils/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import '../../menu/menu_view.dart';
import '../../shared_components/header_logo.dart';
import '../../shared_components/header_title.dart';
import '../../utils/custom_layout.dart';
import '../../utils/global.dart';
import 'widgets/pdf_card.dart';

class SchoolSpacePage extends StatefulWidget {
  const SchoolSpacePage({super.key});

  @override
  SchoolSpacePageState createState() => SchoolSpacePageState();
}

class SchoolSpacePageState extends State<SchoolSpacePage> {
  @override
  Widget build(BuildContext context) {
    return CustomLayout(
      appBar: HeaderLogo(appBarHeight: Global.screenHeight * 0.3),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          print("cc");
          print(state);
          if (state is UserLoading) {
            print(state);
            return const Text('Loading');
          } else if (state is UserLoggedIn) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderTitle(AppLocalizations.of(context)!.my3il),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: CustomTheme.primaryColorLight.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Text(
                    'Votre espace est relié ! Vous pouvez désormais consulter vos notes et absences :).',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                ...?state.user.documents?.map((doc) => PdfCard(
                      filePath: doc.file!.path,
                      title: doc.title,
                    )),
              ],
            );
          } else if (state is UserWihtoutLink) {
            return Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: HeaderTitle('My3iL'),
                ),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: CustomTheme.primaryColorLight.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Text(
                    'Cet espace vous permet de relier votre compte Exnet 3il à l\'application pour consulter vos notes et absences.',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: Global.screenHeight * 0.2),
                CustomButton(
                  text: 'Relier mon compte',
                  onPressed: () {
                    context.push('/linkAccountForm');
                  },
                ),
              ],
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
      bottomBar: const MenuBarView(),
    );
  }
}
