import 'dart:convert';

class DepositParams {
  int amount;
  String methodOfFunding;
  String sourceId;

  DepositParams({
    required this.amount,
    required this.methodOfFunding,
    required this.sourceId,
  });

  factory DepositParams.fromRawJson(String str) =>
      DepositParams.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DepositParams.fromJson(Map<String, dynamic> json) => DepositParams(
        amount: json["amount"],
        methodOfFunding: json["methodOfFunding"],
        sourceId: json["sourceId"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "methodOfFunding": methodOfFunding,
        "sourceId": sourceId,
      };
}
