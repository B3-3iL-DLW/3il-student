import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../users/cubit/user_cubit.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? icon;

  const CustomAppBar({super.key, this.title, this.icon});

  @override
  Widget build(BuildContext context) {
    final userState = context.watch<UserCubit>().state;
    String className = '';
    if (userState is UserLoaded) {
      className = userState.user.entity.className ?? '';
    }
    return AppBar(
      backgroundColor: const Color(0xFF005067),
      title: title != null ? Text(title!) : const SizedBox.shrink(),
      flexibleSpace: Stack(
        alignment: Alignment.center,
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
          if (icon != null)
            Positioned(
              right: 0,
              child: icon!,
            ),
          Text(
            className,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70.0);
}
