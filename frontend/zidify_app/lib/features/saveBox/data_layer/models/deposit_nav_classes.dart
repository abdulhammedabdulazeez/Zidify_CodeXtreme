import 'package:zidify_app/features/saveBox/data_layer/models/deposit_params_models.dart';
import 'package:zidify_app/utils/constants/navigation_params/params_classes.dart';

sealed class DepositNavigationParams extends NavigationParams {
  const DepositNavigationParams();
}

class DepositSecondScreenParams extends DepositNavigationParams {
  final double amount;

  const DepositSecondScreenParams({required this.amount});

  @override
  Map<String, dynamic> toJson() => {
        'type': 'DepositSecondScreenParams',
        'amount': amount,
      };

  factory DepositSecondScreenParams.fromJson(Map<String, dynamic> json) {
    return DepositSecondScreenParams(
      amount: json['amount'] as double,
    );
  }
}

class DepositThirdScreenParams extends DepositNavigationParams {
  final DepositParams depositParams;

  const DepositThirdScreenParams({required this.depositParams});

  @override
  Map<String, dynamic> toJson() => {
        'type': 'DepositThirdScreenParams',
        'depositParams':
            depositParams.toJson(), // Ensure DepositParams also has toJson
      };

  factory DepositThirdScreenParams.fromJson(Map<String, dynamic> json) {
    return DepositThirdScreenParams(
      depositParams:
          DepositParams.fromJson(json['depositParams'] as Map<String, dynamic>),
    );
  }
}
