import 'package:zidify_app/features/saveBox/data_layer/models/withdrawal_params_models.dart';
import 'package:zidify_app/utils/constants/navigation_params/params_classes.dart';

sealed class WithdrawalNavigationParams extends NavigationParams {
  const WithdrawalNavigationParams();
}

class WithdrawalSecondScreenParams extends WithdrawalNavigationParams {
  final double amount;

  const WithdrawalSecondScreenParams({required this.amount});

  @override
  Map<String, dynamic> toJson() => {
        'type': 'WithdrawalSecondScreenParams',
        'amount': amount,
      };

  factory WithdrawalSecondScreenParams.fromJson(Map<String, dynamic> json) {
    return WithdrawalSecondScreenParams(
      amount: json['amount'] as double,
    );
  }
}

class WithdrawalThirdScreenParams extends WithdrawalNavigationParams {
  final WithdrawalParams withdrawalParams;

  const WithdrawalThirdScreenParams({required this.withdrawalParams});

  @override
  Map<String, dynamic> toJson() => {
        'type': 'WithdrawalThirdScreenParams',
        'withdrawalParams': withdrawalParams
            .toJson(), // Ensure WithdrawalParams also has toJson
      };

  factory WithdrawalThirdScreenParams.fromJson(Map<String, dynamic> json) {
    return WithdrawalThirdScreenParams(
      withdrawalParams: WithdrawalParams.fromJson(
          json['withdrawalParams'] as Map<String, dynamic>),
    );
  }
}
