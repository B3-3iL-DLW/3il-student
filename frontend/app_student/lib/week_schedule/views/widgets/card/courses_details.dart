import 'package:app_student/api/events/entities/event_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CourseDetails extends StatelessWidget {
  final EventEntity event;

  const CourseDetails({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    const borderColor = Color(0xFF005067);
    Color cardColor = const Color(0xFF007A8D).withOpacity(0.3);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 50,
          child: Column(
            children: [
              Text(event.horaires.startAt),
              Text(event.horaires.endAt),
            ],
          ),
        ),
        Card(
          color: cardColor,
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: borderColor,
                  width: 10.0,
                ),
              ),
            ),
            width: 300,
            height: 110,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: event.creneau == 3
                    ? [
                        Center(
                          child: ColorFiltered(
                            colorFilter: const ColorFilter.mode(
                                Colors.white, BlendMode.srcIn),
                            child: SvgPicture.asset(
                              'assets/images/eating.svg',
                              width: 40,
                              height: 40,
                            ),
                          ),
                        )
                      ]
                    : [
                        const Text('1h30',
                            style: TextStyle(color: Colors.white)),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(' ${event.activite}'),
                            ColorFiltered(
                              colorFilter: const ColorFilter.mode(
                                  Colors.white, BlendMode.srcIn),
                              child: SvgPicture.asset(
                                event.visio
                                    ? 'assets/images/teams.svg'
                                    : 'assets/images/school.svg',
                                width: 40,
                                height: 40,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text('Salle: ${event.salle}'),
                      ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
