import 'package:app_student/routes.dart';
import 'package:app_student/users/cubit/user_cubit.dart';
import 'package:app_student/utils/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'api/api_service.dart';
import 'api/users/repositories/user_repository.dart';
import 'config/config.dart';
import 'config/prod_config.dart';
import 'login/cubit/login_cubit.dart';
import 'utils/global.dart';

void main() async {
  await dotenv.load();

  initializeDateFormatting('fr_FR', null).then((_) {
    runApp(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider<Config>(
            create: (_) => ProdConfig(),
          ),
          RepositoryProvider<UserRepository>(
            create: (context) => UserRepository(
              apiService: ApiService(apiUrl: context.read<Config>().apiUrl),
            ),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<UserCubit>(
                create: (context) => UserCubit(
                      userRepository: context.read<UserRepository>(), loginCubit: context.read<LoginCubit>(),
                    )..fetchUser()),
          ],
          child: const MyApp(),
        ),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      routes: AppRoutes.routes,
      initialLocation: '/login',
      errorPageBuilder: (context, state) {
        return MaterialPage<void>(
          child: Scaffold(
            body: Center(
              child: Text(
                  AppLocalizations.of(context)!.error404(state.uri.toString())),
            ),
          ),
        );
      },
    );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'my3iL',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // Orange 3IL
        focusColor: CustomTheme.secondaryColor,
        primaryColor: CustomTheme.primaryColor,
        // Bleu 3IL
        secondaryHeaderColor: CustomTheme.primaryColor,
        fontFamily: 'Arial',
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fr'),
      ],
      routerConfig: router,
      builder: (context, child) {
        Global.init(context);
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: const TextScaler.linear(1.0)),
          child: child!,
        );
      },
    );
  }
}
