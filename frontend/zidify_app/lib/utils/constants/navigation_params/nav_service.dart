import 'package:zidify_app/features/saveBox/data_layer/models/deposit_nav_classes.dart';
import 'package:zidify_app/features/saveBox/data_layer/models/deposit_params_models.dart';
import 'package:zidify_app/features/saveBox/data_layer/models/withdrawal_nav_classes.dart';
import 'package:zidify_app/features/saveBox/data_layer/models/withdrawal_params_models.dart';
import 'package:zidify_app/utils/constants/navigation_params/nav_params_coded.dart';
import 'package:zidify_app/utils/constants/navigation_params/params_classes.dart';
import 'package:zidify_app/utils/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationService {
  // SaveBox Deposit Navigation
  static void navigateToDepositSecond(BuildContext context, double amount) {
    final params = DepositSecondScreenParams(amount: amount);
    _navigateWithParams(context, AppTexts.depositSecondScreenName, params);
  }

  static void navigateToDepositThird(
      BuildContext context, DepositParams depositParams) {
    final params = DepositThirdScreenParams(depositParams: depositParams);
    _navigateWithParams(context, AppTexts.depositThirdScreenName, params);
  }

  // SaveBox Withdrawal Navigation
  static void navigateToWithdrawalSecond(BuildContext context, double amount) {
    final params = WithdrawalSecondScreenParams(amount: amount);
    _navigateWithParams(context, AppTexts.withdrawSecondScreenName, params);
  }

  static void navigateToWithdrawalThird(
      BuildContext context, WithdrawalParams withdrawalParams) {
    final params =
        WithdrawalThirdScreenParams(withdrawalParams: withdrawalParams);
    _navigateWithParams(context, AppTexts.withdrawThirdScreenName, params);
  }

  // Private helper method for navigation
  static void _navigateWithParams(
      BuildContext context, String routeName, NavigationParams params) {
    final jsonParams = NavigationParamsCodec.toJson(params);
    context.pushNamed(routeName, extra: jsonParams);
  }
}
