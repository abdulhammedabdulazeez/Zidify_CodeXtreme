import 'dart:convert';

import 'package:zidify_app/features/user/domain_layer/entities/user_entity.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

class UserModel {
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
  UserSavingsTotal? userSavingsTotal;
  List<Activity> activities;

  UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    this.dob,
    this.address,
    this.identificationType,
    this.identificationNumber,
    this.nationality,
    this.occupation,
    this.googleId,
    this.avatar,
    required this.isEmailVerified,
    required this.isPhoneNumberVerified,
    required this.verified,
    required this.refreshToken,
    this.emailVerificationToken,
    this.emailVerificationTokenExpiry,
    this.passwordChangedAt,
    this.passwordResetOtp,
    this.passwordResetOtpExpiry,
    required this.createdAt,
    required this.updatedAt,
    this.userSavingsTotal,
    this.activities = const [], // Default to empty list
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        phoneNumber: json["phoneNumber"],
        dob: json["dob"],
        address: json["address"],
        identificationType: json["identificationType"],
        identificationNumber: json["identificationNumber"],
        nationality: json["nationality"],
        occupation: json["occupation"],
        googleId: json["googleId"],
        avatar: json["avatar"],
        isEmailVerified: json["isEmailVerified"],
        isPhoneNumberVerified: json["isPhoneNumberVerified"],
        verified: json["verified"],
        refreshToken: json["refreshToken"],
        emailVerificationToken: json["emailVerificationToken"],
        emailVerificationTokenExpiry: json["emailVerificationTokenExpiry"],
        passwordChangedAt: json["passwordChangedAt"],
        passwordResetOtp: json["passwordResetOtp"],
        passwordResetOtpExpiry: json["passwordResetOtpExpiry"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        userSavingsTotal: json["userSavingsTotal"] != null
            ? UserSavingsTotal.fromJson(json["userSavingsTotal"])
            : null,
        activities: json["activities"] != null
            ? List<Activity>.from(
                json["activities"].map((x) => Activity.fromJson(x)))
            : [],
      );
}

class Activity {
  String id;
  String userId;
  int amount;
  String category;
  String description;
  DateTime createdAt;
  DateTime updatedAt;

  Activity({
    required this.id,
    required this.userId,
    required this.amount,
    required this.category,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        id: json["id"],
        userId: json["userId"],
        amount: json["amount"],
        category: json["category"],
        description: json["description"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );
}

class UserSavingsTotal {
  String id;
  String userId;
  int totalSaveGoals;
  int totalLockBoxes;
  int totalSaveBox;
  int overallTotal;
  DateTime createdAt;
  DateTime updatedAt;

  UserSavingsTotal({
    required this.id,
    required this.userId,
    required this.totalSaveGoals,
    required this.totalLockBoxes,
    required this.totalSaveBox,
    required this.overallTotal,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserSavingsTotal.fromJson(Map<String, dynamic> json) =>
      UserSavingsTotal(
        id: json["id"],
        userId: json["userId"],
        totalSaveGoals: json["totalSaveGoals"],
        totalLockBoxes: json["totalLockBoxes"],
        totalSaveBox: json["totalSaveBox"],
        overallTotal: json["overallTotal"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );
}

extension UserXModel on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      dob: dob,
      address: address,
      identificationType: identificationType,
      identificationNumber: identificationNumber,
      nationality: nationality,
      occupation: occupation,
      googleId: googleId,
      avatar: avatar,
      isEmailVerified: isEmailVerified,
      isPhoneNumberVerified: isPhoneNumberVerified,
      verified: verified,
      refreshToken: refreshToken,
      emailVerificationToken: emailVerificationToken,
      emailVerificationTokenExpiry: emailVerificationTokenExpiry,
      passwordChangedAt: passwordChangedAt,
      passwordResetOtp: passwordResetOtp,
      passwordResetOtpExpiry: passwordResetOtpExpiry,
      createdAt: createdAt,
      updatedAt: updatedAt,
      userSavingsTotal: UserSavingsTotalEntity(
        id: userSavingsTotal!.id,
        userId: userSavingsTotal!.userId,
        totalSaveGoals: userSavingsTotal!.totalSaveGoals,
        totalLockBoxes: userSavingsTotal!.totalLockBoxes,
        totalSaveBox: userSavingsTotal!.totalSaveBox,
        overallTotal: userSavingsTotal!.overallTotal,
        createdAt: userSavingsTotal!.createdAt,
        updatedAt: userSavingsTotal!.updatedAt,
      ),
      activities: activities
          .map((activity) => ActivityEntity(
                id: activity.id,
                userId: activity.userId,
                amount: activity.amount,
                category: activity.category,
                description: activity.description,
                createdAt: activity.createdAt,
                updatedAt: activity.updatedAt,
              ))
          .toList(),
    );
  }
}
