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
          throw Exception(e);
        }
      });
    } on HttpException catch (he) {
      throw HttpException('HTTP error: $he');
    } on SocketException catch (_) {
      throw SocketException('Pas de connexion internet');
    } on FormatException catch (fe) {
      throw FormatException('Erreur de format: $fe');
    } on TypeError catch (_) {
      throw TypeError();
    }
  }
}
