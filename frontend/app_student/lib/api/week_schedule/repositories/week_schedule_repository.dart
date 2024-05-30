import 'dart:async';
import 'dart:io';

import 'package:app_student/api/api_service.dart';
import 'package:app_student/api/week_schedule/entities/week_schedule_entity.dart';
import 'package:app_student/api/week_schedule/models/week_schedule_model.dart';

class WeekScheduleRepository {
  final ApiService apiService;

  WeekScheduleRepository({required this.apiService});

  Future<List<WeekScheduleModel>> getWeeksSchedule(className) async {
    try {
      return await apiService.getData('/api/timetable?class_param=$className',
              (item) {
            try {
              final entity = WeekScheduleEntity.fromJson(item);
              return WeekScheduleModel.fromEntity(entity);
            } catch (e) {
              throw FormatException('Format incorrect: $e');
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