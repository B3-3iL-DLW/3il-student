import 'package:app_student/utils/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../users/cubit/user_cubit.dart';
import '../utils/global.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? widget;

  const CustomAppBar({super.key, this.title, this.widget});

  @override
  Widget build(BuildContext context) {
    final userState = context.watch<UserCubit>().state;
    String className = '';
    if (userState is UserPartialLoaded) {
      className = userState.user.className ?? '';
    }
    return AppBar(
      backgroundColor: CustomTheme.primaryColor,
      title: title != null
          ? Text(title!, style: CustomTheme.text.toColorWhite)
          : const SizedBox.shrink(),
      flexibleSpace: Stack(
        children: [
          ClipRect(
            child: Center(
              child: Opacity(
                opacity: 0.5,
                child: Transform.scale(
                  scale: 2.0,
                  child: Image.asset(
                    'assets/images/3il-icon-white.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: Text(
                className,
                style: CustomTheme.subtitle.toBold.toColorWhite,
              ),
            ),
          ),
          if (widget != null)
            SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Center(child: widget!),
                ],
              ),
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(Global.screenHeight * 0.07);
}
