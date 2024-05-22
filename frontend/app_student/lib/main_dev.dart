import 'package:app_student/config/dev_config.dart';
import 'package:app_student/routes.dart';
import 'package:app_student/utils/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import 'config/config.dart';
import 'utils/global.dart';

void main() async {
  await dotenv.load();

  initializeDateFormatting('fr_FR', null).then((_) {
    runApp(
      Provider<Config>(
        create: (_) => DevConfig(),
        child: const MyApp(),
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
      theme: CustomTheme.theme,
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
