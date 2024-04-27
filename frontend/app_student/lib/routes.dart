// lib/routes.dart
import 'package:app_student/account/views/account.dart';
import 'package:app_student/api/api_service.dart';
import 'package:app_student/api/class_groups/repositories/class_group_repository.dart';
import 'package:app_student/api/users/repositories/user_repository.dart';
import 'package:app_student/api/week_schedule/repositories/week_schedule_repository.dart';
import 'package:app_student/class_groups/cubit/class_group_cubit.dart';
import 'package:app_student/config/config.dart';
import 'package:app_student/profil/views/profil.dart';
import 'package:app_student/users/cubit/user_cubit.dart';
import 'package:app_student/week_schedule/cubit/week_schedule_cubit.dart';
import 'package:app_student/week_schedule/views/week_schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'account/account_cubit.dart';
import 'api/account/repositories/account_repository.dart';
import 'class_groups/views/class_group.dart';
import 'login/cubit/login_cubit.dart';
import 'login/views/login.dart';

class AppRoutes {
  static const classListPage = '/classList';
  static const loginPage = '/login';
  static const schedulePage = '/schedule';
  static const profilPage = '/profil';
  static const accountPage = '/account';

  static final routes = [
    GoRoute(
      path: classListPage,
      pageBuilder: (context, state) => MaterialPage<void>(
        key: state.pageKey,
        child: MultiRepositoryProvider(
          providers: [
            RepositoryProvider(
                create: (context) => ClassGroupRepository(
                    apiService:
                        ApiService(apiUrl: context.read<Config>().apiUrl))),
            RepositoryProvider(
                create: (context) => UserRepository(
                    apiService:
                        ApiService(apiUrl: context.read<Config>().apiUrl))),
          ],
          child: MultiBlocProvider(providers: [
            BlocProvider(
              create: (context) => ClassGroupCubit(
                classRepository: context.read<ClassGroupRepository>(),
              )..fetchClasses(),
            ),
            BlocProvider(
              create: (context) =>
                  UserCubit(userRepository: context.read<UserRepository>())
                    ..fetchUser(),
            ),
          ], child: const ClassGroupPage()),
        ),
      ),
    ),
    GoRoute(
      path: loginPage,
      pageBuilder: (context, state) => MaterialPage<void>(
        key: state.pageKey,
        child: MultiRepositoryProvider(
          providers: [
            RepositoryProvider(
                create: (context) => UserRepository(
                    apiService:
                        ApiService(apiUrl: context.read<Config>().apiUrl))),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => LoginCubit(context.read<UserRepository>()),
              ),
              BlocProvider(
                create: (context) =>
                    UserCubit(userRepository: context.read<UserRepository>())
                      ..fetchUser(),
              ),
            ],
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
                RepositoryProvider(
                    create: (context) => UserRepository(
                        apiService:
                            ApiService(apiUrl: context.read<Config>().apiUrl))),
              ],
              child: MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => WeekScheduleCubit(
                        weekScheduleRepository: WeekScheduleRepository(
                            apiService: ApiService(
                                apiUrl: context.read<Config>().apiUrl)),
                        initialDate: DateTime.now(),
                        userCubit: context.read<UserCubit>()),
                  ),
                  BlocProvider(
                    create: (context) => UserCubit(
                        userRepository: context.read<UserRepository>())
                      ..fetchUser(),
                  ),
                ],
                child: const WeekSchedulePage(),
              ),
            ))),
    GoRoute(
      path: profilPage,
      pageBuilder: (context, state) => MaterialPage<void>(
        key: state.pageKey,
        child: MultiRepositoryProvider(
          providers: [
            RepositoryProvider(
                create: (context) => UserRepository(
                    apiService:
                        ApiService(apiUrl: context.read<Config>().apiUrl))),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    UserCubit(userRepository: context.read<UserRepository>())
                      ..fetchUser(),
              ),
            ],
            child: const ProfilPage(),
          ),
        ),
      ),
    ),
    GoRoute(
      path: accountPage,
      pageBuilder: (context, state) => MaterialPage<void>(
        key: state.pageKey,
        child: MultiRepositoryProvider(
          providers: [
            RepositoryProvider(
                create: (context) => AccountRepository(
                    apiService:
                        ApiService(apiUrl: context.read<Config>().apiUrl))),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => AccountCubit(
                    accountRepository: context.read<AccountRepository>()),
              ),
            ],
            child: const AccountPage(),
          ),
        ),
      ),
    ),
  ];
}
