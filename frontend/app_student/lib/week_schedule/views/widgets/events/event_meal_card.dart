import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EventMealCard extends StatelessWidget {
  const EventMealCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF007A8D),
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            left: BorderSide(
              color: Color(0xFF005067),
              width: 10.0,
            ),
          ),
        ),
        height: 90,
        child: Padding(
            padding:
            const EdgeInsets.only(left: 20.0, right: 20, bottom: 3, top: 3),
            child: Center(
              child: ColorFiltered(
                colorFilter: const ColorFilter.mode(
                    Colors.white, BlendMode.srcIn),
                child: SvgPicture.asset(
                  'assets/images/eating.svg',
                  width: 50,
                  height: 50,
                ),
              ),
            ),
        ),
      ),
    );
  }
}
