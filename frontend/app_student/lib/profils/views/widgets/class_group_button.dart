import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ClassGroupButton extends StatelessWidget {
  const ClassGroupButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, top: 80.0, right: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            height: 50.0,
            child: ElevatedButton(
              style: ButtonStyle(
                textStyle: MaterialStateProperty.all<TextStyle>(
                  const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).focusColor),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                ),
              ),
              onPressed: () {
                GoRouter.of(context).go('/class-list');
              },
              child: const Text('Changer de classe'),
            ),
          ),
        ],
      ),
    );
  }
}