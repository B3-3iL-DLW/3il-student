import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class INETextField extends StatelessWidget {
  final TextEditingController controller;

  const INETextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 25.0,
          top: 10.0,
          right: 25.0), // Ajout d'un padding à gauche, en haut et à droite
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.loginIneLabel,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 10.0),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.loginIneHint,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(3.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).focusColor),
                borderRadius: BorderRadius.circular(3.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
