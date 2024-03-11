import '../entities/class_group_entity.dart';

class ClassGroupModel {
  final ClassGroupEntity classGroup;

  ClassGroupModel({required this.classGroup});

  String get name => classGroup.name;
  String get file => classGroup.file;
}
