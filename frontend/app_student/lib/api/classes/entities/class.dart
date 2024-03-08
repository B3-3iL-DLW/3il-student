class Class {
  final String file;
  final String name;

  Class({required this.file, required this.name});

  factory Class.fromJson(Map<String, dynamic> json) {
    return Class(
      file: json['file'],
      name: json['name'],
    );
  }
}
