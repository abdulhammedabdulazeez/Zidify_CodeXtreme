import 'package:zidify_app/features/saveBox/data_layer/models/fund_dests_sources.dart';
import 'package:zidify_app/features/saveBox/data_layer/models/withdrawal_params_models.dart';
import 'package:zidify_app/features/saveBox/domain_layer/blocs/fund_destinations/cubit/fund_destination_cubit.dart';
import 'package:zidify_app/features/saveBox/domain_layer/blocs/withdraw/bloc/withdraw_bloc.dart';
import 'package:zidify_app/features/saveBox/ui/widgets/payment_option_item.dart';
import 'package:zidify_app/service_locator.dart';
import 'package:zidify_app/utils/constants/colors.dart';
import 'package:zidify_app/utils/constants/navigation_params/nav_service.dart';
import 'package:zidify_app/utils/constants/sizes.dart';
import 'package:zidify_app/utils/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class WithdrawSecondScreen extends StatefulWidget {
  final double amount;

  const WithdrawSecondScreen({
    required this.amount,
    super.key,
  });

  @override
  State<WithdrawSecondScreen> createState() => _WithdrawSecondScreenState();
}

class _WithdrawSecondScreenState extends State<WithdrawSecondScreen> {
  late FundDestinationCubit fundCubit = sl<FundDestinationCubit>();

  String navigateWithdrawRoute() {
    return '${AppTexts.savingsRoute}${AppTexts.saveBoxRoute}${AppTexts.withdrawFirstScreenRoute}'
        '${AppTexts.withdrawSecondScreenRoute}${AppTexts.withdrawThirdScreenRoute}';
  }

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (mounted) {
    //     context.read<SaveBoxWithdrawalBloc>().add(OnResetWithdrawalSelectionEvent());
    //   }
    // });
    fundCubit.getFundDestinations();
  }

  void onContinue(WithdrawalOptionSelectedState state) {
    final selectedOptionName = state.highlightedItem.type;
    final withdrawalId = state.highlightedItem.destinationId;
    print("Selected Option: $selectedOptionName");
    print("Selected Deposit: ${state.activeWithdrawalType}");

    print("Amount: ${widget.amount}");

    // Perform any additional logic here
    final withdrawData = WithdrawalParams(
      amount: widget.amount.toInt(),
      extWithdrawalDestinationId: withdrawalId,
      extWithdrawalType: selectedOptionName,
    );

    // Navigate to the next screen
    NavigationService.navigateToWithdrawalThird(
      context,
      withdrawData,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = sl<SaveBoxWithdrawalBloc>();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppSizes.appBarHeight,
          horizontal: AppSizes.defaultSpace,
        ),
        child: Scaffold(
          appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.all(8.0), // Adjust padding as needed
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
            actions: [
              Text(
                'Step 2 of 2',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppColors.darkGrey),
              ),
            ],
          ),
          body: GestureDetector(
            onTap: () => bloc.add(const OnResetWithdrawalSelectionEvent()),
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(top: AppSizes.spaceBtwSections),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppTexts.fundDestination,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: AppColors.dark),
                    ),
                    const SizedBox(height: AppSizes.spaceBtwItemsSmall),
                    Text(
                      AppTexts.withdrawalOptionText,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: AppColors.dark),
                    ),
                    const SizedBox(height: AppSizes.spaceBtwItemsLarge),

                    // DEPOSIT BLOC
                    BlocBuilder<SaveBoxWithdrawalBloc, SaveBoxWithdrawalState>(
                      bloc: bloc,
                      builder: (context, state) {
                        return BlocBuilder<FundDestinationCubit,
                            FundDestinationState>(
                          bloc: fundCubit,
                          builder: (context, fundDestState) {
                            if (fundDestState is FundDestinationLoadingState) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (fundDestState
                                is FundDestinationErrorState) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.error,
                                      size: 48,
                                      color: Colors.red,
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      fundDestState.message,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              );
                            } else if (fundDestState
                                is FundDestinationLoadedState) {
                              final withdrawalOptionList =
                                  fundDestState.fundDestinations.fundDestGroups;

                              return Column(
                                children: [
                                  Column(
                                    children: withdrawalOptionList.map((entry) {
                                      final depositType =
                                          entry.type; // E.g., "Bank", "Momo"
                                      final items = entry
                                          .destinations; // List of options under this deposit type
                                      final isExpanded = state
                                              is WithdrawalOptionSelectedState &&
                                          state.activeWithdrawalType ==
                                              depositType; // Check expanded state
                                      final highlightedItem =
                                          state is WithdrawalOptionSelectedState
                                              ? (state).highlightedItem
                                              : FundDestination(
                                                  destinationId: "",
                                                  userId: "",
                                                  type: "",
                                                  accountNumber: "",
                                                  accountName: "",
                                                  momoName: "",
                                                  momoNumber: "",
                                                ); // Current highlighted items
                                      final selectedItemId = highlightedItem
                                          .destinationId; // Highlighted item for the type

                                      return Column(
                                        children: [
                                          // Deposit Type Header (Clickable to toggle selection)
                                          GestureDetector(
                                            onTap: () => bloc.add(
                                              OnSelectWithdrawalOptionEvent(
                                                FundDestGroup(
                                                  type: depositType,
                                                  destinations: items,
                                                ),
                                              ),
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: isExpanded
                                                    ? AppColors.primary
                                                    : AppColors.grey,
                                              ),
                                              padding: const EdgeInsets.all(16),
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              width: double.infinity,
                                              child: Text(
                                                depositType,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(
                                                      color: isExpanded
                                                          ? Colors.white
                                                          : Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                              ),
                                            ),
                                          ),

                                          // Render list of items if expanded
                                          if (isExpanded)
                                            Column(
                                              children: items.map(
                                                (item) {
                                                  final isSelected =
                                                      selectedItemId ==
                                                          item.destinationId; // Check selection
                                                  final isMomo =
                                                      depositType == "momo";

                                                  return GestureDetector(
                                                    onTap: () => bloc.add(
                                                      OnHighlightListOptionEvent(
                                                          depositType, item),
                                                    ),
                                                    // child: Text('data'),
                                                    child:
                                                        WithdrawalPaymentOption(
                                                      isSelected: isSelected,
                                                      isMomo: isMomo,
                                                      item: item,
                                                    ),
                                                  );
                                                },
                                              ).toList(),
                                            ),
                                        ],
                                      );
                                    }).toList(),
                                  ),

                                  const SizedBox(
                                      height: AppSizes.spaceBtwSections),

                                  // Conditionally Display the Button
                                  if (state is WithdrawalOptionSelectedState &&
                                      state.highlightedItem.destinationId
                                          .isNotEmpty)
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: () => onContinue(state),
                                        child: const Text(AppTexts.deposit),
                                      ),
                                    ),
                                ],
                              );
                            } else {
                              return const SizedBox(
                                child: Text('There is nothing here'),
                              );
                            }
                          },
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
