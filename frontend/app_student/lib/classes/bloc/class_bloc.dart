import 'dart:async';

import 'package:app_student/api/classes/entities/class.dart';
import 'package:app_student/api/classes/repositories/class_repository.dart';



class ClassBloc {
  final ClassRepository classRepository;
  final _classController = StreamController<List<Class>>();

  Stream<List<Class>> get classStream => _classController.stream;

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
