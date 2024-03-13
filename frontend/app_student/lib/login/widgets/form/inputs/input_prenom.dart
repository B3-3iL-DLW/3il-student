import 'package:flutter/material.dart';

class FirstnameTextField extends StatelessWidget {
  final TextEditingController controller;

  const FirstnameTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, top: 30.0, right: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Prénom',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 10.0),
          TextFormField(
            controller: controller,
            style: TextStyle(
              color: Colors.grey[600],
            ),
            decoration: InputDecoration(
              hintText: 'Entrez votre prénom ici',
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
