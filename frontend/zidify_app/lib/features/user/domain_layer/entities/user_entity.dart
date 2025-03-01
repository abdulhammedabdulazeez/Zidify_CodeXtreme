class UserEntity {
  String id;
  String email;
  String firstName;
  String lastName;
  String phoneNumber;
  dynamic dob;
  dynamic address;
  dynamic identificationType;
  dynamic identificationNumber;
  dynamic nationality;
  dynamic occupation;
  dynamic googleId;
  dynamic avatar;
  bool isEmailVerified;
  bool isPhoneNumberVerified;
  bool verified;
  String refreshToken;
  dynamic emailVerificationToken;
  dynamic emailVerificationTokenExpiry;
  dynamic passwordChangedAt;
  dynamic passwordResetOtp;
  dynamic passwordResetOtpExpiry;
  DateTime createdAt;
  DateTime updatedAt;
  UserSavingsTotalEntity userSavingsTotal;
  List<ActivityEntity> activities;

  UserEntity({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.dob,
    required this.address,
    required this.identificationType,
    required this.identificationNumber,
    required this.nationality,
    required this.occupation,
    required this.googleId,
    required this.avatar,
    required this.isEmailVerified,
    required this.isPhoneNumberVerified,
    required this.verified,
    required this.refreshToken,
    required this.emailVerificationToken,
    required this.emailVerificationTokenExpiry,
    required this.passwordChangedAt,
    required this.passwordResetOtp,
    required this.passwordResetOtpExpiry,
    required this.createdAt,
    required this.updatedAt,
    required this.userSavingsTotal,
    required this.activities,
  });
}

class UserSavingsTotalEntity {
  String id;
  String userId;
  int totalSaveGoals;
  int totalLockBoxes;
  int totalSaveBox;
  int overallTotal;
  DateTime createdAt;
  DateTime updatedAt;

  UserSavingsTotalEntity({
    required this.id,
    required this.userId,
    required this.totalSaveGoals,
    required this.totalLockBoxes,
    required this.totalSaveBox,
    required this.overallTotal,
    required this.createdAt,
    required this.updatedAt,
  });
}

class ActivityEntity {
  String id;
  String userId;
  int amount;
  String category;
  String description;
  DateTime createdAt;
  DateTime updatedAt;

  ActivityEntity({
    required this.id,
    required this.userId,
    required this.amount,
    required this.category,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });
}
