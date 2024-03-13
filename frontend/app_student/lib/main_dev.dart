import 'package:app_student/api/week_schedule/repositories/week_schedule_repository.dart';
import 'package:app_student/config/dev_config.dart';
import 'package:app_student/week_schedule/views/week_schedule.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'api/api_service.dart';
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
    return Provider<Config>(
      create: (_) => DevConfig(),
      child: RepositoryProvider<WeekScheduleRepository>(
        create: (context) => WeekScheduleRepository(
            apiService: ApiService(apiUrl: context.read<Config>().apiUrl),
            className: 'B3 Groupe 3 DLW-FA'),
        child: const MaterialApp(home: WeekSchedulePage()),
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
