import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/custom_theme.dart';

class EventMealCard extends StatelessWidget {
  const EventMealCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      color: CustomTheme.primaryColor,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            left: BorderSide(
              color: CustomTheme.primaryColor,
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
              colorFilter:
                  const ColorFilter.mode(Colors.white, BlendMode.srcIn),
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
