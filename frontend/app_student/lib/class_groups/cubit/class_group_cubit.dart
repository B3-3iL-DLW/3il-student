import 'package:app_student/api/class_groups/models/class_group_model.dart';
import 'package:app_student/api/users/models/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../api/class_groups/repositories/class_group_repository.dart';
import '../../api/users/repositories/user_repository.dart';

part 'class_group_state.dart';

class ClassGroupCubit extends Cubit<ClassGroupState> {
  final ClassGroupRepository classRepository;
  final UserRepository userRepository;

  ClassGroupCubit({required this.classRepository, required this.userRepository})
      : super(ClassGroupInitial());

  Future<void> fetchClasses() async {
    try {
      emit(ClassGroupLoading());
      final classes = await classRepository.getClasses();

      emit(ClassGroupLoaded(classes));
    } catch (e) {
      emit(ClassGroupError(e.toString()));
    }
  }

  Future<UserModel> getConnectedUser() async {
    return userRepository.getUser();
  }
}
