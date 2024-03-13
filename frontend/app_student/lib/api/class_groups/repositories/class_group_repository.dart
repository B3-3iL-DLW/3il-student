import 'package:app_student/api/class_groups/entities/class_group_entity.dart';
import 'package:app_student/api/api_service.dart';
import 'package:app_student/api/class_groups/models/class_group_model.dart';

class ClassGroupRepository {
  final ApiService apiService;

  ClassGroupRepository({required this.apiService});

  Future<List<ClassGroupModel>> getClasses() {
    return apiService.getData('/api/classes', (item) {
      final entity = ClassGroupEntity.fromJson(item);
      return ClassGroupModel(classGroup: entity);
    });
  }
}
