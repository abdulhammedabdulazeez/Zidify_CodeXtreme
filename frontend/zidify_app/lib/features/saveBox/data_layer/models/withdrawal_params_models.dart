import 'dart:convert';

class WithdrawalParams {
  int amount;
  String extWithdrawalDestinationId;
  String extWithdrawalType;

  WithdrawalParams({
    required this.amount,
    required this.extWithdrawalDestinationId,
    required this.extWithdrawalType,
  });

  factory WithdrawalParams.fromRawJson(String str) =>
      WithdrawalParams.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WithdrawalParams.fromJson(Map<String, dynamic> json) =>
      WithdrawalParams(
        amount: json["amount"],
        extWithdrawalDestinationId: json["extWithdrawalDestinationId"],
        extWithdrawalType: json["extWithdrawalType"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "extWithdrawalDestinationId": extWithdrawalDestinationId,
        "extWithdrawalType": extWithdrawalType,
      };
}
