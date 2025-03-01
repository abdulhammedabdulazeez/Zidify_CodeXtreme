// ignore_for_file: public_member_api_docs, sort_constructors_first
class DepositOption {
  final String name;
  final List<ListOption> options;

  DepositOption({
    required this.name,
    required this.options,
  });
}

class ListOption {
  final String id;
  final String accountNumber;
  final String? cvc; // CVC is optional as Momo doesn’t have it
  final String name;

  ListOption({
    required this.id,
    required this.accountNumber,
    this.cvc,
    required this.name,
  });

  ListOption copyWith({
    String? id,
    String? accountNumber,
    String? cvc,
    String? name,
  }) {
    return ListOption(
      id: id ?? this.id,
      accountNumber: accountNumber ?? this.accountNumber,
      cvc: cvc ?? this.cvc,
      name: name ?? this.name,
    );
  }
}

// new deposit models implementation

// This class represents a single funding source
class FundingSource {
  final String sourceId;
  final String userId;
  final String type;
  final String? accountNumber;
  final String? bankName;
  final String? accountName;
  final String? cardNumber;
  final String? cardExpiry;
  final String? cardHolder;
  final String? momoNumber;
  final String? momoName;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  FundingSource({
    required this.sourceId,
    required this.userId,
    required this.type,
    this.accountNumber,
    this.bankName,
    this.accountName,
    this.cardNumber,
    this.cardExpiry,
    this.cardHolder,
    this.momoNumber,
    this.momoName,
    this.createdAt,
    this.updatedAt,
  });

  FundingSource copyWith({
    String? sourceId,
    String? userId,
    String? type,
    String? accountNumber,
    String? bankName,
    String? accountName,
    String? cardNumber,
    String? cardExpiry,
    String? cardHolder,
    String? momoNumber,
    String? momoName,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return FundingSource(
      sourceId: sourceId ?? this.sourceId,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      accountNumber: accountNumber ?? this.accountNumber,
      bankName: bankName ?? this.bankName,
      accountName: accountName ?? this.accountName,
      cardNumber: cardNumber ?? this.cardNumber,
      cardExpiry: cardExpiry ?? this.cardExpiry,
      cardHolder: cardHolder ?? this.cardHolder,
      momoNumber: momoNumber ?? this.momoNumber,
      momoName: momoName ?? this.momoName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory FundingSource.fromJson(Map<String, dynamic> json) {
    return FundingSource(
      sourceId: json['id'],
      userId: json['userId'],
      type: json['type'],
      accountNumber: json['accountNumber'],
      bankName: json['bankName'],
      accountName: json['accountName'],
      cardNumber: json['cardNumber'],
      cardExpiry: json['cardExpiry'],
      cardHolder: json['cardHolder'],
      momoNumber: json['momoNumber'],
      momoName: json['momoName'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

// This class represents a group of funding sources of the same type
class FundingSourceGroup {
  final String type;
  final List<FundingSource> sources;

  FundingSourceGroup({
    required this.type,
    required this.sources,
  });
}

// This class represents a collection of FundingSourceGroup
class FundingSourceCollection {
  final List<FundingSourceGroup> groups;

  FundingSourceCollection({
    required this.groups,
  });

  factory FundingSourceCollection.fromJson(List<dynamic> json) {
    final List<FundingSource> sources =
        json.map((item) => FundingSource.fromJson(item)).toList();

    final Map<String, List<FundingSource>> groupedSources = {};
    for (final source in sources) {
      if (groupedSources.containsKey(source.type)) {
        groupedSources[source.type]!.add(source);
      } else {
        groupedSources[source.type] = [source];
      }
    }

    final List<FundingSourceGroup> groups = groupedSources.entries
        .map((entry) =>
            FundingSourceGroup(type: entry.key, sources: entry.value))
        .toList();

    return FundingSourceCollection(groups: groups);
  }
}
