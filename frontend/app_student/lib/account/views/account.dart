import 'package:app_student/account/views/forms/account_link_form.dart';
import 'package:app_student/account/views/widgets/pdf_card.dart';
import 'package:app_student/utils/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../menu/menu_view.dart';
import '../../shared_components/header_logo.dart';
import '../../shared_components/header_title.dart';
import '../../utils/custom_layout.dart';
import '../../utils/global.dart';
import '../account_cubit.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late final AccountCubit accountCubit;

  @override
  void initState() {
    super.initState();
    accountCubit = BlocProvider.of<AccountCubit>(context);
    accountCubit.checkStudentId();

    accountCubit.stream.listen((state) {
      if (state is AccountLoggedIn) {
        accountCubit.fetchMarks();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomLayout(
      appBar: HeaderLogo(appBarHeight: Global.screenHeight * 0.3),
      body: BlocBuilder<AccountCubit, AccountState>(
        builder: (context, state) {
          if (state is AccountLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AccountLoaded) {
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
                PdfCard(
                    filePath: state.marksFile.path, title: 'Relevé de notes'),
                const SizedBox(height: 20),
                PdfCard(
                    filePath: state.absencesFile.path,
                    title: "Relevé d'absences"),
              ],
            );
          } else if (state is AccountInitial) {
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
                    'Cet espace vous permet de relier votre compte My3iL à l\'application pour consulter vos notes et absences.',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              LoginFormPage(accountCubit: accountCubit),
                        ),
                      );
                    },
                    child: const Text('Relier mon compte'),
                  ),
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
