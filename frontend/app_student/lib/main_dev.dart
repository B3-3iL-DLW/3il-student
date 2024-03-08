import 'package:app_student/api/api_service.dart';
import 'package:app_student/api/classes/repositories/class_repository.dart';
import 'package:app_student/classes/views/class.dart';
import 'package:app_student/config/dev_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'classes/bloc/class_bloc.dart';
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
    final config = Provider.of<Config>(context);
    final ApiService apiService = ApiService(apiUrl: config.apiUrl);
    final classBloc =
        ClassBloc(classRepository: ClassRepository(apiService: apiService));

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
