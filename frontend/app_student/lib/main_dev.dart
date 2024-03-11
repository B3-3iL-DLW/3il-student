import 'package:app_student/config/dev_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'api/api_service.dart';
import 'api/day_schedule/repositories/day_schedule.dart';
import 'config/config.dart';
import 'day_schedule/views/day_schedule.dart';

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
    return Provider<Config>(
      create: (_) => DevConfig(),
      child: RepositoryProvider<DayScheduleRepository>(
        create: (context) => DayScheduleRepository(
            apiService: ApiService(apiUrl: context.read<Config>().apiUrl), className: 'B3 Groupe 3 DLW-FA'),
        child: const MaterialApp(home: DaySchedulePage()),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Provider<Config>(
  //     create: (_) => DevConfig(),
  //     child: RepositoryProvider<ClassGroupRepository>(
  //       create: (context) => ClassGroupRepository(
  //           apiService: ApiService(apiUrl: context.read<Config>().apiUrl)),
  //       child: const MaterialApp(home: ClassListPage()),
  //     ),
  //   );
  // }
}
