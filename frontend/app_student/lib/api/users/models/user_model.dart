import 'package:app_student/api/documents/models/document_model.dart';
import 'package:app_student/api/users/entities/user_entity.dart';

class UserModel {
  UserEntity entity;

  UserModel({required this.entity});

  String? get firstName => entity.firstName;

  set firstName(String? value) => entity.firstName = value;

  DateTime? get birthDate => entity.birthDate;

  set birthDate(DateTime? value) => entity.birthDate = value;

  String? get className => entity.className;

  set className(String? value) => entity.className = value;

  String? get ine => entity.ine;

  set ine(String? value) => entity.ine = value;

  int? get studentId => entity.studentId;

  set studentId(int? value) => entity.studentId = value;

  List<DocumentModel>? get documents => entity.documents
      ?.map((documentEntity) => DocumentModel.fromEntity(documentEntity))
      .toList();

  set documents(List<DocumentModel>? value) {
    entity.documents = value?.map((model) => model.toEntity()).toList();
  }

  Map<String, dynamic> toJson() => {
        'entity': entity.toJson(),
      };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        entity: json['entity'] != null
            ? UserEntity.fromJson(json['entity'])
            : UserEntity(),
      );

  // fait un tostring de user custom genre User : {firstName: 'toto', birthDate: '2022-01-01', className: '3A', ine: '123456789
  @override
  String toString() {
    return 'User : {firstName: $firstName, birthDate: $birthDate, className: $className, ine: $ine, studentId: $studentId, documents: $documents}';
  }
}
