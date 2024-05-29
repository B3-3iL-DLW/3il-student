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
    final localizations = AppLocalizations.of(context)!;

    return CustomLayout(
      appBar: HeaderLogo(appBarHeight: Global.screenHeight * 0.3),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is UserLoggedIn) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderTitle(localizations.my3il),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: CustomTheme.primaryColorLight.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    localizations.my3ilSpaceLinked,
                    style: const TextStyle(
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
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: HeaderTitle(localizations.my3il),
                ),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: CustomTheme.primaryColorLight.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    localizations.linkMy3ilSpace,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: Global.screenHeight * 0.2),
                CustomButton(
                  text: localizations.linkAccountButton,
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
