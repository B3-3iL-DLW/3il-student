import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../utils/custom_theme.dart';

class NetworkError extends StatelessWidget {
  const NetworkError({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.noConnectionMessage),
          backgroundColor: CustomTheme.secondaryColor,
        ),
      );
    });
    return const Center(
      child: Icon(
        Icons.wifi_off,
        size: 100,
        color: CustomTheme.secondaryColor,
      ),
    );
  }
}
