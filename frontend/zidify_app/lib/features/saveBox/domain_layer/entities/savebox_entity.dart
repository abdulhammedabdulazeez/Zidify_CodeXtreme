class SaveboxEntity {
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
  List<SaveBoxActivityEntity> activities;

  SaveboxEntity({
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
}

class SaveBoxActivityEntity {
  String id;
  String userId;
  int amount;
  String category;
  String description;
  DateTime createdAt;
  DateTime updatedAt;

  SaveBoxActivityEntity({
    required this.id,
    required this.userId,
    required this.amount,
    required this.category,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });
}
