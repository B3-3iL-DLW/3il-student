import 'package:app_student/api/class_groups/entities/class_group_entity.dart';
import 'package:app_student/api/api_service.dart';

class ClassGroupRepository {
  final ApiService apiService;

  ClassGroupRepository({required this.apiService});

  Future<List<ClassGroupEntity>> getClasses() {
    return apiService.getData(
        '/api/classes', (item) => ClassGroupEntity.fromJson(item));
  }
}
