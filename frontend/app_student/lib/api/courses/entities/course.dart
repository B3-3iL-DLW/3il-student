class Course {
  final String creneau;
  final String activite;
  final String id;
  final String couleur;
  final Map<String, String> horaire;
  final String salle;

  Course({
    required this.creneau,
    required this.activite,
    required this.id,
    required this.couleur,
    required this.horaire,
    required this.salle,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      creneau: json['creneau'] ?? 'null',
      activite: json['activite'] ?? 'null',
      id: json['id'] ?? 'null',
      couleur: json['couleur'] ?? 'null',
      horaire: {
        'start': json['horaire']['start'] ?? 'null',
        'end': json['horaire']['end'] ?? 'null',
      },
      salle: json['salle'] ?? 'null',
    );
  }
}
