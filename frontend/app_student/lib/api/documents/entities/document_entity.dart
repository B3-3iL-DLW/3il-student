import 'dart:io';

class DocumentEntity {
  final String title;
  final File? file;

  DocumentEntity({required this.title, required this.file});

  Map<String, dynamic> toJson() => {
        'title': title,
        'file': file!.path,
      };

  factory DocumentEntity.fromJson(Map<String, dynamic> json) {
    return DocumentEntity(
      title: json['title'],
      file: File(json['file']),
    );
  }
}
