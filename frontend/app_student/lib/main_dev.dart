import 'package:app_student/config/dev_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'api/api_service.dart';
import 'api/class_groups/repositories/class_group_repository.dart';
import 'config/config.dart';
import 'login/cubit/login_cubit.dart';
import 'login/views/login_page.dart';

void main() {
  final ClassGroupRepository classGroupRepository = ClassGroupRepository(
    apiService: ApiService(apiUrl: DevConfig().apiUrl),
  );

  runApp(
    MultiProvider(
      providers: [
        Provider<Config>(
          create: (_) => DevConfig(),
        ),
        RepositoryProvider<ClassGroupRepository>(
          create: (context) => classGroupRepository,
        ),
      ],
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
        fontFamily: 'Arial',
      ),
      home: BlocProvider(
        create: (context) => LoginCubit(),
        child: const LoginPage(),
      ),
    );
  }
}
