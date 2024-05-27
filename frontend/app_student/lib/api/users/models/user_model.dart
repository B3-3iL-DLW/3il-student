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

  @override
  String toString() {
    return 'User : {firstName: $firstName, birthDate: $birthDate, className: $className, ine: $ine, studentId: $studentId, documents: ${documents?.map((doc) => doc.toString()).join(', ')}}';
  }

  bool get isEmpty {
    return firstName == null || firstName!.isEmpty;
  }

  bool get hasFirstName {
    return firstName != null && firstName!.isNotEmpty;
  }

  bool get hasBirthDate {
    return birthDate != null;
  }

  bool get hasClassName {
    return className != null && className!.isNotEmpty;
  }

  bool get hasIne {
    return ine != null && ine!.isNotEmpty;
  }

  bool get hasStudentId {
    return studentId != null;
  }

  bool get hasDocuments {
    return documents != null && documents!.isNotEmpty;
  }
}
