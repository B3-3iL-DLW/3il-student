import 'dart:io';

import 'package:app_student/api/class_groups/entities/class_group_entity.dart';
import 'package:app_student/api/api_service.dart';
import 'package:app_student/api/class_groups/models/class_group_model.dart';

class ClassGroupRepository {
  final ApiService apiService;

  ClassGroupRepository({required this.apiService});

  Future<List<ClassGroupModel>> getClasses() {
    try {
      return apiService.getData('/api/classes', (item) {
        try {
          final entity = ClassGroupEntity.fromJson(item);
          return ClassGroupModel(classGroup: entity);
        } catch (e) {
          throw FormatException('Failed to parse JSON: $e');
        }
      });
    } on HttpException catch (he) {
      throw Exception('HTTP error: $he');
    } on FormatException catch (fe) {
      throw Exception('Failed to parse JSON: $fe');
    } on SocketException catch (se) {
      throw Exception('No internet connection: $se');
    } on TypeError catch (te) {
      throw Exception('Type error: $te');
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }
}
