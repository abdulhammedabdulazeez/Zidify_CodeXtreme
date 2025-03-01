// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// This class represents a single funding destination
class FundDestination {
  String destinationId;
  String type;
  String userId;
  String? accountNumber;
  String? bankName;
  String? accountName;
  String? momoNumber;
  String? momoName;
  DateTime? createdAt;
  DateTime? updatedAt;

  FundDestination({
    required this.destinationId,
    required this.type,
    required this.userId,
    this.accountNumber,
    this.bankName,
    this.accountName,
    this.momoNumber,
    this.momoName,
    this.createdAt,
    this.updatedAt,
  });

  factory FundDestination.fromRawJson(String str) =>
      FundDestination.fromJson(json.decode(str));

  factory FundDestination.fromJson(Map<String, dynamic> json) =>
      FundDestination(
        destinationId: json["id"],
        type: json["type"],
        accountNumber: json["accountNumber"],
        bankName: json["bankName"],
        accountName: json["accountName"],
        momoNumber: json["momoNumber"],
        momoName: json["momoName"],
        userId: json["userId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  FundDestination copyWith({
    String? destinationId,
    String? type,
    String? accountNumber,
    String? bankName,
    String? accountName,
    String? momoNumber,
    String? momoName,
    String? userId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return FundDestination(
      destinationId: destinationId ?? this.destinationId,
      type: type ?? this.type,
      accountNumber: accountNumber ?? this.accountNumber,
      bankName: bankName ?? this.bankName,
      accountName: accountName ?? this.accountName,
      momoNumber: momoNumber ?? this.momoNumber,
      momoName: momoName ?? this.momoName,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

// This class represents a group of funding destinations of the same type
class FundDestGroup {
  final String type;
  final List<FundDestination> destinations;

  FundDestGroup({
    required this.type,
    required this.destinations,
  });
}

// This class represents a collection of FundDestGroup
class FundDestCollection {
  final List<FundDestGroup> fundDestGroups;

  FundDestCollection({
    required this.fundDestGroups,
  });

  factory FundDestCollection.fromJson(List<dynamic> json) {
    final List<FundDestination> destinations =
        json.map((item) => FundDestination.fromJson(item)).toList();

    final Map<String, List<FundDestination>> groupedDestinations = {};
    for (var destination in destinations) {
      if (groupedDestinations.containsKey(destination.type)) {
        groupedDestinations[destination.type]!.add(destination);
      } else {
        groupedDestinations[destination.type] = [destination];
      }
    }

    final List<FundDestGroup> groups = groupedDestinations.entries
        .map((entry) =>
            FundDestGroup(type: entry.key, destinations: entry.value))
        .toList();

    return FundDestCollection(fundDestGroups: groups);
  }
}
