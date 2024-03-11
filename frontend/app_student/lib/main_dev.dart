import 'package:app_student/api/schedule/repositories/schedule_repository.dart';
import 'package:app_student/config/dev_config.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'api/api_service.dart';
import 'api/class_groups/repositories/class_group_repository.dart';
import 'class_groups/views/class_group_view.dart';
import 'config/config.dart';
import 'schedule/views/schedule_view.dart';

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

  // @override
  // Widget build(BuildContext context) {
  //   return Provider<Config>(
  //     create: (_) => DevConfig(),
  //     child: RepositoryProvider<ScheduleRepository>(
  //       create: (context) => ScheduleRepository(
  //           apiService: ApiService(apiUrl: context.read<Config>().apiUrl),
  //           className: 'B3 Groupe 3 DLW-FA'),
  //       child: const MaterialApp(home: SchedulePage()),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Provider<Config>(
      create: (_) => DevConfig(),
      child: RepositoryProvider<ClassGroupRepository>(
        create: (context) => ClassGroupRepository(
            apiService: ApiService(apiUrl: context.read<Config>().apiUrl)),
        child: const MaterialApp(home: ClassListPage()),
      ),
    );
  }
}
