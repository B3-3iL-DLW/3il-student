import 'dart:async';
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
    } on ArgumentError catch (_) {
      rethrow;
    } on SocketException catch (_) {
      rethrow;
    } on FormatException catch (_) {
      rethrow;
    } on TimeoutException catch (_) {
      rethrow;
    } on HttpException catch (_) {
      rethrow;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
