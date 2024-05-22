import 'dart:io';

import 'package:app_student/api/class_groups/models/class_group_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../api/class_groups/repositories/class_group_repository.dart';

part 'class_group_state.dart';

class ClassGroupCubit extends Cubit<ClassGroupState> {
  final ClassGroupRepository classRepository;

  ClassGroupCubit({required this.classRepository}) : super(ClassGroupInitial());

  Future<void> fetchClasses() async {
    try {
      emit(ClassGroupLoading());
      final classes = await classRepository.getClasses();
      emit(ClassGroupLoaded(classes));
    } on SocketException catch (se) {
      emit(ClassGroupError(se.message));
    } on FormatException catch (fe) {
      emit(ClassGroupError(fe.message));
    } on HttpException catch (he) {
      emit(ClassGroupError(he.message));
    }
    catch (e) {
      emit(ClassGroupError(e.toString()));
    }
  }
}
