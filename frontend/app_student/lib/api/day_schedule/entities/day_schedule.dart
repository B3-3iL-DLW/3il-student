import '../../courses/entities/course.dart';

class DaySchedule {
  final String date;
  final String jour;
  final List<Course> cours;

  DaySchedule({
    required this.date,
    required this.jour,
    required this.cours,
  });

  factory DaySchedule.fromJson(Map<String, dynamic> json) {
    var coursFromJson = json['cours'] as List;
    List<Course> coursList =
        coursFromJson.map((i) => Course.fromJson(i)).toList();

    return DaySchedule(
      date: json['date'],
      jour: json['jour'],
      cours: coursList,
    );
  }
}
