import 'dart:async';

import 'package:app_student/api/class_groups/entities/class_group_entity.dart';
import 'package:app_student/api/class_groups/repositories/class_group_repository.dart';

class ClassBloc {
  final ClassRepository classRepository;
  final _classController = StreamController<List<ClassGroupEntity>>();

  Stream<List<ClassGroupEntity>> get classStream => _classController.stream;

  ClassBloc({required this.classRepository}) {
    fetchClasses();
  }

  fetchClasses() async {
    final classes = await classRepository.getClasses();
    _classController.sink.add(classes);
  }

  dispose() {
    _classController.close();
  }
}
