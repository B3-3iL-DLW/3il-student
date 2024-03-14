// lib/routes.dart
import 'package:app_student/api/api_service.dart';
import 'package:app_student/api/class_groups/repositories/class_group_repository.dart';
import 'package:app_student/api/users/repositories/user_repository.dart';
import 'package:app_student/api/week_schedule/repositories/week_schedule_repository.dart';
import 'package:app_student/class_groups/cubit/class_group_cubit.dart';
import 'package:app_student/config/config.dart';
import 'package:app_student/users/cubit/user_cubit.dart';
import 'package:app_student/week_schedule/cubit/week_schedule_cubit.dart';
import 'package:app_student/week_schedule/views/week_schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'class_groups/views/class_group_page.dart';
import 'login/cubit/login_cubit.dart';
import 'login/views/login_page.dart';

class AppRoutes {
  static const classListPage = '/classList';
  static const loginPage = '/login';
  static const schedulePage = '/schedule';

  static final routes = [
    GoRoute(
        path: classListPage,
        pageBuilder: (context, state) => MaterialPage<void>(
            key: state.pageKey,
            child: MultiRepositoryProvider(
                providers: [
                  RepositoryProvider(
                      create: (context) => ClassGroupRepository(
                          apiService: ApiService(
                              apiUrl: context.read<Config>().apiUrl))),
                  RepositoryProvider(create: (context) => UserRepository()),
                ],
                child: BlocProvider(
                    create: (context) => ClassGroupCubit(
                        classRepository: context.read<ClassGroupRepository>(),
                        userRepository: context.read<UserRepository>()),
                    child: const ClassGroupPage())))),
    GoRoute(
      path: loginPage,
      pageBuilder: (context, state) => MaterialPage<void>(
        key: state.pageKey,
        child: RepositoryProvider(
          create: (context) => UserRepository(),
          child: BlocProvider(
            create: (context) => LoginCubit(context.read<UserRepository>()),
            child: const LoginPage(),
          ),
        ),
      ),
    ),
    GoRoute(
        path: schedulePage,
        pageBuilder: (context, state) => MaterialPage<void>(
            key: state.pageKey,
            child: MultiRepositoryProvider(
              providers: [
                RepositoryProvider(
                    create: (context) => WeekScheduleRepository(
                        apiService:
                            ApiService(apiUrl: context.read<Config>().apiUrl))),
                RepositoryProvider(create: (context) => UserRepository()),
              ],
              child: MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => UserCubit(
                        userRepository: context.read<UserRepository>()),
                  ),
                  BlocProvider(
                    create: (context) => WeekScheduleCubit(
                        weekScheduleRepository: WeekScheduleRepository(
                            apiService: ApiService(
                                apiUrl: context.read<Config>().apiUrl)),
                        userRepository: context.read<UserRepository>(),
                        initialDate: DateTime.now()),
                  ),
                ],
                child: const WeekSchedulePage(),
              ),
            ))),
    GoRoute(
        name: 'schedule_date',
        path: '/schedule:date',
        pageBuilder: (context, state) {
          final date = DateTime.parse(state.pathParameters['date']!);
          return MaterialPage<void>(
              key: state.pageKey,
              child: MultiRepositoryProvider(
                providers: [
                  RepositoryProvider(
                      create: (context) => WeekScheduleRepository(
                          apiService: ApiService(
                              apiUrl: context.read<Config>().apiUrl))),
                  RepositoryProvider(create: (context) => UserRepository()),
                ],
                child: MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => UserCubit(
                          userRepository: context.read<UserRepository>()),
                    ),
                    BlocProvider(
                      create: (context) => WeekScheduleCubit(
                          weekScheduleRepository: WeekScheduleRepository(
                              apiService: ApiService(
                                  apiUrl: context.read<Config>().apiUrl)),
                          userRepository: context.read<UserRepository>(),
                          initialDate: DateTime.now()),
                    ),
                  ],
                  child: const WeekSchedulePage(),
                ),
              ));
        }),
  ];
}
