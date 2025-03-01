import 'package:zidify_app/features/saveBox/data_layer/models/withdrawal_params_models.dart';
import 'package:zidify_app/features/saveBox/domain_layer/blocs/make_withdrawal/cubit/withdraw_cubit.dart';
import 'package:zidify_app/features/saveBox/ui/widgets/withdrawal_details.dart';
import 'package:zidify_app/service_locator.dart';
import 'package:zidify_app/utils/components/trans_successful.dart';
import 'package:zidify_app/utils/constants/colors.dart';
import 'package:zidify_app/utils/constants/sizes.dart';
import 'package:zidify_app/utils/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class WithdrawThirdScreen extends StatefulWidget {
  final WithdrawalParams withdrawalParams;

  const WithdrawThirdScreen({super.key, required this.withdrawalParams});

  @override
  State<WithdrawThirdScreen> createState() => _WithdrawThirdScreenState();
}

class _WithdrawThirdScreenState extends State<WithdrawThirdScreen> {
  late WithdrawCubit withdrawCubit = sl<WithdrawCubit>();

  @override
  void initState() {
    super.initState();
    withdrawCubit.resetState(); // Reset the state of the cubit
  }

  // @override
  // void dispose() {
  //   WithdrawCubit.close(); // Clean up the cubit when widget is disposed
  //   super.dispose();
  // }

  void onSubmitted() {
    withdrawCubit.makeWithdrawal(widget.withdrawalParams);
  }

  void goHome() {
    context.go('${AppTexts.savingsRoute}${AppTexts.saveBoxRoute}');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppSizes.appBarHeight,
          horizontal: AppSizes.defaultSpace,
        ),
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      context.pop(); // Navigate back to the previous screen
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Confirm Withdrawal",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: AppColors.dark),
                  ),
                ),
              ],
            ),
          ),
          body: SizedBox(
            child: BlocConsumer<WithdrawCubit, WithdrawState>(
              bloc: withdrawCubit,
              listener: (context, state) {
                // First dismiss any existing dialog
                if (state is WithdrawFailureState ||
                    state is WithdrawSuccessState) {
                  Navigator.of(context, rootNavigator: true).pop();
                }

                if (state is WithdrawLoadingState) {
                  showDialog(
                    context: context,
                    barrierDismissible:
                        false, // Prevent dismissing by tapping outside
                    builder: (BuildContext context) {
                      return const Center(
                        child:
                            CircularProgressIndicator(), // You can also create a custom dialog here
                      );
                    },
                  );
                } else if (state is WithdrawFailureState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                if (state is WithdrawSuccessState) {
                  return TransactionSuccessful(
                    box: "SaveBox",
                    onContinue: goHome,
                  );
                }
                return WithdrawalDetails(
                  withdrawalParams: widget.withdrawalParams,
                  onSubmitted: onSubmitted,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
