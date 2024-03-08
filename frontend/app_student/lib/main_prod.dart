import 'package:app_student/api/api_service.dart';
import 'package:app_student/api/day_schedule/repositories/day_schedule.dart';
import 'package:app_student/config/prod_config.dart';
import 'package:app_student/day_schedules/bloc/day_schedule_bloc.dart';
import 'package:app_student/day_schedules/views/day_schedule.dart';
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
    final config = Provider.of<Config>(context);
    final ApiService apiService = ApiService(apiUrl: config.apiUrl);

    final dayScheduleBloc = DayScheduleBloc(
        dayScheduleRepository: DayScheduleRepository(
            apiService: apiService, className: 'B3%20Groupe%203%20DLW-FA'));

    return MaterialApp(
      title: 'Class List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DayScheduleView(
        dayScheduleBloc: dayScheduleBloc,
      ),
    );
  }
}
