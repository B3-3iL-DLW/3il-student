// lib/routes.dart
import 'package:app_student/api/api_service.dart';
import 'package:app_student/api/class_groups/repositories/class_group_repository.dart';
import 'package:app_student/api/users/repositories/user_repository.dart';
import 'package:app_student/api/week_schedule/repositories/week_schedule_repository.dart';
import 'package:app_student/class_groups/cubit/class_group_cubit.dart';
import 'package:app_student/config/config.dart';
import 'package:app_student/profil/views/profil_page.dart';
import 'package:app_student/school_space/views/forms/link_account_form.dart';
import 'package:app_student/school_space/views/school_space_page.dart';
import 'package:app_student/users/cubit/user_cubit.dart';
import 'package:app_student/week_schedule/cubit/week_schedule_cubit.dart';
import 'package:app_student/week_schedule/views/week_schedule_page.dart';
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
  static const profilPage = '/profil';
  static const schoolSpace = '/school_space';
  static const linkAccountFormPage = '/linkAccountForm';

  static final routes = [
    GoRoute(
      redirect: (BuildContext context, GoRouterState state) {
        final userCubit = context.read<UserCubit>();
        if (userCubit.state is UserWithoutClass) {
          return classListPage;
        } else if ((userCubit.state is UserWihtoutLink) ||
            (userCubit.state is UserLoggedIn)) {
          return schedulePage;
        }

        return loginPage;
      },
      path: classListPage,
      pageBuilder: (context, state) => MaterialPage<void>(
        key: state.pageKey,
        child: MultiRepositoryProvider(
          providers: [
            RepositoryProvider(
                create: (context) => ClassGroupRepository(
                    apiService:
                        ApiService(apiUrl: context.read<Config>().apiUrl))),
          ],
          child: MultiBlocProvider(providers: [
            BlocProvider(
              create: (context) => ClassGroupCubit(
                classRepository: context.read<ClassGroupRepository>(),
              )..fetchClasses(),
            ),
          ], child: const ClassGroupPage()),
        ),
      ),
    ),
    GoRoute(
      redirect: (BuildContext context, GoRouterState state) {
        final userCubit = context.read<UserCubit>();

        if (userCubit.state is UserWithoutClass) {
          return classListPage;
        } else if ((userCubit.state is UserWihtoutLink) ||
            (userCubit.state is UserLoggedIn)) {
          return schedulePage;
        }

        return loginPage;
      },
      path: loginPage,
      pageBuilder: (context, state) => MaterialPage<void>(
        key: state.pageKey,
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  LoginCubit(userRepository: context.read<UserRepository>()),
            ),
          ],
          child: const LoginPage(),
        ),
      ),
    ),
    GoRoute(
      redirect: (BuildContext context, GoRouterState state) {
        final userCubit = context.read<UserCubit>();

        if ((userCubit.state is UserWihtoutLink) ||
            (userCubit.state is UserLoggedIn)) {
          return schedulePage;
        } else if (userCubit.state is UserWithoutClass) {
          return classListPage;
        }

        return loginPage;
      },
      path: schedulePage,
      pageBuilder: (context, state) => MaterialPage<void>(
        key: state.pageKey,
        child: MultiRepositoryProvider(
          providers: [
            RepositoryProvider(
              create: (context) => WeekScheduleRepository(
                apiService: ApiService(apiUrl: context.read<Config>().apiUrl),
              ),
            ),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => WeekScheduleCubit(
                  weekScheduleRepository:
                      context.read<WeekScheduleRepository>(),
                  userCubit: context.read<UserCubit>(),
                  initialDate: DateTime.now(),
                )..fetchUserAndSchedule(),
              ),
            ],
            child: const WeekSchedulePage(),
          ),
        ),
      ),
    ),
    GoRoute(
      redirect: (BuildContext context, GoRouterState state) {
        final userCubit = context.read<UserCubit>();

        if ((userCubit.state is UserWihtoutLink) ||
            (userCubit.state is UserLoggedIn)) {
          return profilPage;
        } else if (userCubit.state is UserWithoutClass) {
          return classListPage;
        }

        return loginPage;
      },
      path: profilPage,
      pageBuilder: (context, state) => MaterialPage<void>(
        key: state.pageKey,
        child: const ProfilPage(),
      ),
    ),
    GoRoute(
      redirect: (BuildContext context, GoRouterState state) {
        final userCubit = context.read<UserCubit>();

        if ((userCubit.state is UserWihtoutLink) ||
            (userCubit.state is UserLoggedIn)) {
          return schoolSpace;
        } else if (userCubit.state is UserWithoutClass) {
          return classListPage;
        }

        return loginPage;
      },
      path: schoolSpace,
      pageBuilder: (context, state) => MaterialPage<void>(
        key: state.pageKey,
        child: const SchoolSpacePage(),
      ),
    ),
    GoRoute(
      redirect: (BuildContext context, GoRouterState state) {
        final userCubit = context.read<UserCubit>();

        if (userCubit.state is UserWihtoutLink) {
          return linkAccountFormPage;
        } else if (userCubit.state is UserLoggedIn) {
          return schoolSpace;
        } else if (userCubit.state is UserWithoutClass) {
          return classListPage;
        }

        return loginPage;
      },
      path: linkAccountFormPage, // Use the new constant here
      pageBuilder: (context, state) => MaterialPage<void>(
        key: state.pageKey,
        child: const LinkAccountForm(), // Use the LinkAccountForm here
      ),
    ),
  ];
}
