import 'package:flutter/material.dart';

class EventEmptyCard extends StatelessWidget {
  const EventEmptyCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade200,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            left: BorderSide(
              color: Colors.grey,
              width: 10.0,
            ),
          ),
        ),
        height: 110,
      ),
    );
  }
}