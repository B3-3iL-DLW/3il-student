import '../../documents/entities/document_entity.dart';

class UserEntity {
  String? ine;
  String? firstName;
  DateTime? birthDate;
  String? className;
  int? studentId;
  List<DocumentEntity>? documents;

  UserEntity(
      {this.ine,
      this.firstName,
      this.birthDate,
      this.className,
      this.studentId,
      this.documents});

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'className': className,
        'ine': ine,
        'birthDate': birthDate?.toIso8601String(),
        'studentId': studentId,
        'documents': documents?.map((doc) => doc.toJson()).toList(),
      };

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
        firstName: json['firstName'],
        className: json['className'],
        ine: json['ine'],
        birthDate: json['birthDate'] != null
            ? DateTime.parse(json['birthDate'])
            : null,
        studentId: json['studentId'],
        documents: (json['documents'] as List<dynamic>?)
            ?.map((doc) => DocumentEntity.fromJson(doc))
            .toList(),
      );
}
