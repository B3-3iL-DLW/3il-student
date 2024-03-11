part of 'class_group_cubit.dart';

@immutable
abstract class ClassGroupState {}

class ClassGroupInitial extends ClassGroupState {}

class ClassGroupLoading extends ClassGroupState {}

class ClassGroupLoaded extends ClassGroupState {
  final List<ClassGroupEntity> classes;

  ClassGroupLoaded(this.classes);
}

class ClassGroupError extends ClassGroupState {
  final String message;

  ClassGroupError(this.message);
}
