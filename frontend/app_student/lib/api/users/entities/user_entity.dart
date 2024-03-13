class UserEntity {
  final String ine;
  final String firstName;
  final DateTime birthDate;
  final String? promotionName;

  UserEntity(
      {required this.ine,
      required this.firstName,
      required this.birthDate,
      this.promotionName = ''});
}
