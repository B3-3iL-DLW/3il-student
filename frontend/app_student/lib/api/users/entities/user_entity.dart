import 'package:app_student/api/class_groups/entities/class_group_entity.dart';

class UserEntity {
  final String ine;
  final String firstName;
  final DateTime birthDate;
  final ClassGroupEntity? classGroup;

  UserEntity(
      {required this.ine,
      required this.firstName,
      required this.birthDate,
      this.classGroup});
}
