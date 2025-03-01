import 'dart:convert';

import 'package:zidify_app/features/saveBox/domain_layer/entities/savebox_entity.dart';

SaveboxModel saveboxModelFromJson(String str) =>
    SaveboxModel.fromJson(json.decode(str));

String saveboxModelToJson(SaveboxModel data) => json.encode(data.toJson());

class SaveboxModel {
  String id;
  String userId;
  int balance;
  String accountNumber;
  String accountName;
  bool autoSaveEnabled;
  dynamic autoSaveAmount;
  dynamic autoSaveFrequency;
  dynamic autoSaveDayOfTheWeek;
  dynamic autoSaveDayOfTheMonth;
  dynamic autoSaveTime;
  dynamic autoSaveFundingSourceId;
  DateTime createdAt;
  DateTime updatedAt;
  List<SaveBoxActivity> activities;

  SaveboxModel({
    required this.id,
    required this.userId,
    required this.balance,
    required this.accountNumber,
    required this.accountName,
    required this.autoSaveEnabled,
    required this.autoSaveAmount,
    required this.autoSaveFrequency,
    required this.autoSaveDayOfTheWeek,
    required this.autoSaveDayOfTheMonth,
    required this.autoSaveTime,
    required this.autoSaveFundingSourceId,
    required this.createdAt,
    required this.updatedAt,
    required this.activities,
  });

  factory SaveboxModel.fromJson(Map<String, dynamic> json) => SaveboxModel(
        id: json["id"],
        userId: json["userId"],
        balance: json["balance"],
        accountNumber: json["accountNumber"],
        accountName: json["accountName"],
        autoSaveEnabled: json["autoSaveEnabled"],
        autoSaveAmount: json["autoSaveAmount"],
        autoSaveFrequency: json["autoSaveFrequency"],
        autoSaveDayOfTheWeek: json["autoSaveDayOfTheWeek"],
        autoSaveDayOfTheMonth: json["autoSaveDayOfTheMonth"],
        autoSaveTime: json["autoSaveTime"],
        autoSaveFundingSourceId: json["autoSaveFundingSourceId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        activities: json["activities"] == null
            ? []
            : List<SaveBoxActivity>.from(
                json["activities"].map(
                  (x) => SaveBoxActivity.fromJson(x),
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "balance": balance,
        "accountNumber": accountNumber,
        "autoSaveEnabled": autoSaveEnabled,
        "autoSaveAmount": autoSaveAmount,
        "autoSaveFrequency": autoSaveFrequency,
        "autoSaveDayOfTheWeek": autoSaveDayOfTheWeek,
        "autoSaveDayOfTheMonth": autoSaveDayOfTheMonth,
        "autoSaveTime": autoSaveTime,
        "autoSaveFundingSourceId": autoSaveFundingSourceId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };

  // Method to convert SaveboxModel to SaveboxEntity
  SaveboxEntity toEntity() {
    return SaveboxEntity(
      id: id,
      userId: userId,
      balance: balance,
      accountNumber: accountNumber,
      accountName: accountName,
      autoSaveEnabled: autoSaveEnabled,
      autoSaveAmount: autoSaveAmount,
      autoSaveFrequency: autoSaveFrequency,
      autoSaveDayOfTheWeek: autoSaveDayOfTheWeek,
      autoSaveDayOfTheMonth: autoSaveDayOfTheMonth,
      autoSaveTime: autoSaveTime,
      autoSaveFundingSourceId: autoSaveFundingSourceId,
      createdAt: createdAt,
      updatedAt: updatedAt,
      activities: activities.map((activity) => activity.toEntity()).toList(),
    );
  }
}

class SaveBoxActivity {
  String id;
  String userId;
  int amount;
  String category;
  String description;
  DateTime createdAt;
  DateTime updatedAt;

  SaveBoxActivity({
    required this.id,
    required this.userId,
    required this.amount,
    required this.category,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SaveBoxActivity.fromJson(Map<String, dynamic> json) =>
      SaveBoxActivity(
        id: json["id"],
        userId: json["userId"],
        amount: json["amount"],
        category: json["category"],
        description: json["description"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  SaveBoxActivityEntity toEntity() {
    return SaveBoxActivityEntity(
      id: id,
      userId: userId,
      amount: amount,
      category: category,
      description: description,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
