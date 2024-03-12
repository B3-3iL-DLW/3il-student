import 'package:app_student/api/class_groups/models/class_group_model.dart';
import 'package:app_student/api/class_groups/repositories/class_group_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'class_group_state.dart';

class ClassGroupCubit extends Cubit<ClassGroupState> {
  final ClassGroupRepository classRepository;

  ClassGroupCubit({required this.classRepository}) : super(ClassGroupInitial());

  Future<void> fetchClasses() async {
    try {
      emit(ClassGroupLoading());
      final classes = await classRepository.getClasses();
      emit(ClassGroupLoaded(classes));
    } catch (e) {
      emit(ClassGroupError(e.toString()));
    }
  }
}
