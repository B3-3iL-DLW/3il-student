import 'package:app_student/config/dev_config.dart';
import 'package:app_student/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'config/config.dart';

void main() {
  runApp(
    Provider<Config>(
      create: (_) => DevConfig(),
      child: const MyApp(),
    ),
  );
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
      title: '3iL Student App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        focusColor: const Color(0xffE84E0F),
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
    );
  }
}
