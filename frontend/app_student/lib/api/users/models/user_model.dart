import '../entities/user_entity.dart';

class UserModel {
  final UserEntity entity;

  UserModel({required this.entity});

  String get firstName => entity.firstName;
  String get name => entity.firstName;
  DateTime? get birthDate => entity.birthDate;
  String? get className => entity.className;
  String? get ine => entity.ine;
}
