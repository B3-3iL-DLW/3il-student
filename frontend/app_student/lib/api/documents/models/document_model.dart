import 'dart:io';
import 'package:app_student/api/documents/entities/document_entity.dart';

class DocumentModel {
  final DocumentEntity entity;

  DocumentModel({required this.entity});

  String get title => entity.title;

  File? get file => entity.file;

  factory DocumentModel.fromEntity(DocumentEntity entity) {
    return DocumentModel(
      entity: entity,
    );
  }

  DocumentEntity toEntity() {
    return DocumentEntity(
      title: title,
      file: file,
    );
  }

  @override
  String toString() {
    return 'DocumentModel: {title: $title, file: ${file?.path}}';
  }
}
