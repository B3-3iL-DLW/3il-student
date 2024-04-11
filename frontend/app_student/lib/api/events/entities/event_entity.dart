import '../../event_hours/entities/event_hours_entity.dart';

class EventEntity {
  final int id;
  final int creneau;
  final String activite;
  final String couleur;
  final EventHoursEntity horaires;
  final String salle;
  final bool visio;
  final bool repas;
  final bool eval;

  EventEntity({
    required this.id,
    required this.creneau,
    required this.activite,
    required this.couleur,
    required this.horaires,
    required this.salle,
    required this.visio,
    required this.repas,
    required this.eval,
  });

  factory EventEntity.fromJson(Map<String, dynamic> json) {
    return EventEntity(
      creneau: json['creneau'] ?? 'null',
      activite: json['activite'] ?? 'null',
      id: json['id'] ?? 'null',
      couleur: json['couleur'] ?? 'null',
      horaires: EventHoursEntity.fromJson(json['horaire']),
      salle: json['salle'] ?? 'null',
      visio: json['visio'] ?? false,
      repas: json['repas'] ?? false,
      eval: json['eval'] ?? false,
    );
  }
}
