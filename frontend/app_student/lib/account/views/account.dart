import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import '../../menu/menu_view.dart';
import '../../shared_components/header_logo.dart';
import '../../shared_components/header_title.dart';
import '../../utils/custom_layout.dart';
import '../../utils/global.dart';
import '../account_cubit.dart';
import 'widgets/account_dialog.dart';

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
    return BlocBuilder<AccountCubit, AccountState>(
      builder: (context, state) {
        print("caca");
        print(state);
        if (state is AccountLoading) {
          return const CircularProgressIndicator();
        }

        if (state is AccountLoaded) {
          return CustomLayout(
            appBar: HeaderLogo(appBarHeight: Global.screenHeight * 0.3),
            body: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: HeaderTitle('coucou'),
                ),
                Expanded(
                  child: PDFView(
                    filePath: state.marksFile.path,
                  ),
                ),
                Expanded(
                  child: PDFView(
                    filePath: state.absencesFile.path,
                  ),
                ),
              ],
            ),
            bottomBar: const MenuBarView(),
          );
        }

        if (state is AccountInitial) {
          return CustomLayout(
            appBar: HeaderLogo(appBarHeight: Global.screenHeight * 0.3),
            body: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: HeaderTitle('coucou'),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) =>
                            AccountDialog(accountCubit: accountCubit),
                      );
                    },
                    child: const Text('Relier mon compte'),
                  ),
                ),
              ],
            ),
            bottomBar: const MenuBarView(),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}