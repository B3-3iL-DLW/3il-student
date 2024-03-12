class ClassGroupEntity {
  final String file;
  final String name;

  ClassGroupEntity({required this.file, required this.name});

  factory ClassGroupEntity.fromJson(Map<String, dynamic> json) {
    return ClassGroupEntity(
      file: json['file'],
      name: json['name'],
    );
  }
}
