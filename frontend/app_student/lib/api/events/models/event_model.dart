import '../../event_hours/models/event_hours_model.dart';
import '../entities/event_entity.dart';

class EventModel {
  final EventEntity entity;

  EventModel({required this.entity});

  int get id => entity.id;
  int get creneau => entity.creneau;
  String get activite => entity.activite;
  String get couleur => entity.couleur;
  EventHoursModel get horaires => EventHoursModel(entity: entity.horaires);
  String get salle => entity.salle;
  bool get visio => entity.visio;
}
