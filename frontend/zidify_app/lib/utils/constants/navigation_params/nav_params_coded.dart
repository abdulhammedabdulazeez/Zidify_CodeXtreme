import 'package:zidify_app/features/saveBox/data_layer/models/deposit_nav_classes.dart';
import 'package:zidify_app/features/saveBox/data_layer/models/withdrawal_nav_classes.dart';
import 'package:zidify_app/utils/constants/navigation_params/params_classes.dart';

class NavigationParamsCodec {
  static Map<String, dynamic>? toJson(Object? value) {
    if (value == null) return null;

    if (value is NavigationParams) {
      return {
        'type': _getTypeIdentifier(value),
        ...value.toJson(),
      };
    }
    throw Exception('Unknown type for serialization: ${value.runtimeType}');
  }

  static String _getTypeIdentifier(NavigationParams params) {
    return switch (params) {
      // SaveBox Deposit
      DepositSecondScreenParams() => 'DepositSecondScreenParams',
      DepositThirdScreenParams() => 'DepositThirdScreenParams',
      // SaveBox Withdrawal
      WithdrawalSecondScreenParams() => 'WithdrawalSecondScreenParams',
      WithdrawalThirdScreenParams() => 'WithdrawalThirdScreenParams',
      // Add other parameter types here
      _ => throw Exception('Unknown parameter type')
    };
  }

  static NavigationParams? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    return switch (json['type']) {
      // SaveBox Deposit
      'DepositSecondScreenParams' => DepositSecondScreenParams.fromJson(json),
      'DepositThirdScreenParams' => DepositThirdScreenParams.fromJson(json),
      // SaveBox Withdrawal
      'WithdrawalSecondScreenParams' =>
        WithdrawalSecondScreenParams.fromJson(json),
      'WithdrawalThirdScreenParams' =>
        WithdrawalThirdScreenParams.fromJson(json),
      // Add other parameter types here
      _ => throw Exception('Unknown type for deserialization')
    };
  }
}
