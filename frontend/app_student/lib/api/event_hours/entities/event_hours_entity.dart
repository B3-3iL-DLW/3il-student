class EventHoursEntity {
  final String startAt;
  final String endAt;

  EventHoursEntity({
    required this.startAt,
    required this.endAt,
  });

  factory EventHoursEntity.fromJson(Map<String, dynamic> json) {
    return EventHoursEntity(
      startAt: json['startAt'],
      endAt: json['endAt'],
    );
  }
}
