import 'package:app_student/config/prod_config.dart';
import 'package:app_student/profils/views/profil_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'config/config.dart';

void main() {
  runApp(
    Provider<Config>(
      create: (_) => ProdConfig(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Class List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        focusColor: const Color(0xffE84E0F),
      ),
      home: const ProfilPage(),
    );
  }
}
