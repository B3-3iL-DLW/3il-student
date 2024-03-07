import 'package:app_student/api/classes/repositories/class_repository.dart';
import 'package:app_student/classes/views/class.dart';
import 'package:app_student/config/prod_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'classes/bloc/class_bloc.dart';
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
    final config = Provider.of<Config>(context);
    final classBloc =
        ClassBloc(classRepository: ClassRepository(apiUrl: config.apiUrl));

    return MaterialApp(
      title: 'Class List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ClassListPage(
        classBloc: classBloc,
      ),
    );
  }
}
