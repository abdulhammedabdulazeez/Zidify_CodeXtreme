import 'package:zidify_app/features/saveBox/data_layer/models/deposit_params_models.dart';
import 'package:zidify_app/features/saveBox/domain_layer/blocs/make_deposit/cubit/deposit_cubit.dart';
import 'package:zidify_app/features/saveBox/ui/widgets/deposit_details.dart';
import 'package:zidify_app/service_locator.dart';
import 'package:zidify_app/utils/components/trans_successful.dart';
import 'package:zidify_app/utils/constants/colors.dart';
import 'package:zidify_app/utils/constants/sizes.dart';
import 'package:zidify_app/utils/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DepositThirdScreen extends StatefulWidget {
  final DepositParams depositParams;

  const DepositThirdScreen({super.key, required this.depositParams});

  @override
  State<DepositThirdScreen> createState() => _DepositThirdScreenState();
}

class _DepositThirdScreenState extends State<DepositThirdScreen> {
  late DepositCubit depositCubit = sl<DepositCubit>();

  @override
  void initState() {
    super.initState();
    depositCubit.resetState(); // Reset the state of the cubit
  }

  void onSubmitted() {
    depositCubit.makeDeposit(widget.depositParams);
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
                    "Confirm Deposit",
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
            child: BlocConsumer<DepositCubit, DepositState>(
              bloc: depositCubit,
              listener: (context, state) {
                // First dismiss any existing dialog
                if (state is DepositFailureState ||
                    state is DepositSuccessState) {
                  Navigator.of(context, rootNavigator: true).pop();
                }

                if (state is DepositLoadingState) {
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
                } else if (state is DepositFailureState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                if (state is DepositSuccessState) {
                  return TransactionSuccessful(
                    box: "SaveBox",
                    onContinue: goHome,
                  );
                }
                return DepositDetails(
                  depositParams: widget.depositParams,
                  box: "SaveBox",
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
