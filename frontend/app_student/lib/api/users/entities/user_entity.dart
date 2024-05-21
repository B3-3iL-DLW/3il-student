import 'dart:io';

class UserEntity {
  final String? ine;
  final String firstName;
  final DateTime? birthDate;
  final String? className;
  final int? studentId;
  final File? marksFile;
  final File? absencesFile;

  UserEntity(
      {required this.ine,
      required this.firstName,
      required this.birthDate,
      this.className,
      this.studentId,
      this.marksFile,
      this.absencesFile});
}
