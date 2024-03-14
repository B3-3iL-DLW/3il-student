import 'package:app_student/api/events/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    super.key,
    required this.event,
  });

  final EventModel event;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF007A8D).withOpacity(0.3),
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            left: BorderSide(
              color: Color(0xFF005067),
              width: 10.0,
            ),
          ),
        ),
        height: 110,
        child: Padding(
          padding:
          const EdgeInsets.only(left: 20.0, right: 20, bottom: 3, top: 3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: event.creneau == 3
                ? MainAxisAlignment.center
                : MainAxisAlignment.spaceEvenly,
            children: [
              const Text('1h30',
                  style: TextStyle(color: Colors.white, fontSize: 12)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(event.activite,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                        Colors.white, BlendMode.srcIn),
                    child: SvgPicture.asset(
                      event.visio
                          ? 'assets/images/teams.svg'
                          : 'assets/images/school.svg',
                      width: 50,
                      height: 50,
                    ),
                  ),
                ],
              ),
              Text('Salle ${event.salle}',
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}