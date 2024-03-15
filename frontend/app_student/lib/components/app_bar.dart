import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../users/cubit/user_cubit.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? widget;

  const CustomAppBar({super.key, this.title, this.widget});

  @override
  Widget build(BuildContext context) {
    final userState = context.watch<UserCubit>().state;
    String className = '';
    if (userState is UserLoaded) {
      className = userState.user.className ?? '';
    }
    return AppBar(
      backgroundColor: const Color(0xFF005067),
      title: title != null ? Text(title!) : const SizedBox.shrink(),
      flexibleSpace: Stack(
        children: [
          ClipRect(
            child: Center(
              child: Opacity(
                opacity: 0.5,
                child: Transform.scale(
                  scale: 3.0,
                  child: Image.asset(
                    'assets/images/3il-icon-white.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 45.0),
            child: Stack(
              children: [
                Center(
                  child: Text(
                    className,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (widget != null)
                  Positioned(
                    right: 0.0,
                    top: 10.0,
                    child: widget!,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(65.0);
}
