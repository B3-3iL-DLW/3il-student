import 'package:app_student/api/classes/entities/class.dart';
import 'package:app_student/api/api_service.dart';

class ClassRepository {
  final ApiService apiService;

  ClassRepository({required this.apiService});

  Future<List<Class>> getClasses() {
    return apiService.getData('/api/classes', (item) => Class.fromJson(item));
  }
}
