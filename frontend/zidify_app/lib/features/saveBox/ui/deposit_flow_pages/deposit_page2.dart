import 'package:zidify_app/features/saveBox/data_layer/models/deposit_params_models.dart';
import 'package:zidify_app/features/saveBox/data_layer/models/funding_sources_models.dart';
import 'package:zidify_app/features/saveBox/domain_layer/blocs/deposit/bloc/deposit_bloc.dart';
import 'package:zidify_app/features/saveBox/domain_layer/blocs/funding_sources/cubit/funding_sources_cubit.dart';
import 'package:zidify_app/features/saveBox/domain_layer/blocs/saveBox/cubit/save_box_cubit.dart';
import 'package:zidify_app/features/saveBox/ui/widgets/bank_details.dart';
import 'package:zidify_app/features/saveBox/ui/widgets/payment_option_item.dart';
import 'package:zidify_app/service_locator.dart';
import 'package:zidify_app/utils/constants/colors.dart';
import 'package:zidify_app/utils/constants/navigation_params/nav_service.dart';
import 'package:zidify_app/utils/constants/sizes.dart';
import 'package:zidify_app/utils/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DepositSecondScreen extends StatefulWidget {
  final double amount;

  const DepositSecondScreen({
    required this.amount,
    super.key,
  });

  @override
  State<DepositSecondScreen> createState() => _DepositSecondScreenState();
}

class _DepositSecondScreenState extends State<DepositSecondScreen> {
  late FundingSourcesCubit fundingCubit = sl<FundingSourcesCubit>();
  late SaveBoxCubit saveBoxCubit = sl<SaveBoxCubit>();

  String navigateDepositRoute() {
    return '${AppTexts.savingsRoute}${AppTexts.saveBoxRoute}${AppTexts.depositFirstScreenRoute}'
        '${AppTexts.depositSecondScreenRoute}${AppTexts.depositThirdScreenRoute}';
  }
  // Text('You are depositing: \$${widget.amount.toStringAsFixed(2)}')

  @override
  void initState() {
    super.initState();
    // context.read<SaveBoxDepositBloc>().add(OnResetDepositSelectionEvent());
    // context.read<FundingSourcesCubit>().getFundingSources();
    fundingCubit.getFundingSources();
  }

  // @override
  // void dispose() {
  //   saveBoxCubit.close();
  //   fundingCubit.close();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final bloc = sl<SaveBoxDepositBloc>();
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
            onTap: () => bloc.add(const OnResetDepositSelectionEvent()),
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(top: AppSizes.spaceBtwSections),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppTexts.sourceOfFund,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: AppColors.dark),
                    ),
                    const SizedBox(height: AppSizes.spaceBtwItemsSmall),
                    Text(
                      AppTexts.depositOptionText,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: AppColors.dark),
                    ),
                    const SizedBox(height: AppSizes.spaceBtwItemsLarge),

                    // DEPOSIT BLOC
                    BlocBuilder<SaveBoxDepositBloc, SaveBoxDepositState>(
                      bloc: bloc,
                      builder: (context, state) {
                        return BlocBuilder<FundingSourcesCubit,
                            FundingSourcesState>(
                          bloc: fundingCubit,
                          builder: (context, fundingSourceState) {
                            if (fundingSourceState
                                is FundingSourcesLoadingState) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (fundingSourceState
                                is FundingSourcesErrorState) {
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
                                      fundingSourceState.message,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              );
                            } else if (fundingSourceState
                                is FundingSourcesLoadedState) {
                              final depositOptionsList =
                                  fundingSourceState.fundingSources.groups;

                              return Column(
                                children: [
                                  Column(
                                    children: depositOptionsList.map((entry) {
                                      final depositType =
                                          entry.type; // E.g., "Bank", "Momo"
                                      final items = entry
                                          .sources; // List of options under this deposit type
                                      final isExpanded = state
                                              is DepositOptionSelectedState &&
                                          state.activeDepositType ==
                                              depositType; // Check expanded state
                                      final highlightedItem =
                                          state is DepositOptionSelectedState
                                              ? (state).highlightedItem
                                              : FundingSource(
                                                  sourceId: '',
                                                  userId: '',
                                                  type: '',
                                                  momoName: '',
                                                  momoNumber: '',
                                                  cardHolder: '',
                                                  cardNumber: '',
                                                ); // Current highlighted items
                                      final selectedItemId = highlightedItem
                                          .sourceId; // Highlighted item for the type

                                      return Column(
                                        children: [
                                          // Deposit Type Header (Clickable to toggle selection)
                                          GestureDetector(
                                            onTap: () => bloc.add(
                                              OnSelectDepositOptionEvent(
                                                  FundingSourceGroup(
                                                      type: depositType,
                                                      sources: items)),
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
                                                          item.sourceId; // Check selection
                                                  final isMomo =
                                                      depositType == "momo";

                                                  return GestureDetector(
                                                    onTap: () => bloc.add(
                                                      OnHighlightListOptionEvent(
                                                          depositType, item),
                                                    ),
                                                    child: PaymentOption(
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

                                  // Display Bank Details
                                  if (state is DepositInitialState)
                                    BlocBuilder<SaveBoxCubit, SaveBoxState>(
                                      bloc: saveBoxCubit,
                                      builder: (context, state) {
                                        if (state is SaveBoxLoadedState) {
                                          final savebox = state.saveBox;
                                          return BankDetails(saveBox: savebox);
                                        } else {
                                          return const SizedBox();
                                        }
                                      },
                                    ),
                                  // BankDetails(saveBox: savebox,),

                                  const SizedBox(
                                      height: AppSizes.spaceBtwSections),

                                  // Conditionally Display the Button
                                  if (state is DepositOptionSelectedState &&
                                      state.highlightedItem.sourceId.isNotEmpty)
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          final selectedOptionName =
                                              state.highlightedItem.type;
                                          final depositId =
                                              state.highlightedItem.sourceId;
                                          print(
                                              "Selected Option: $selectedOptionName");
                                          print(
                                              "Selected DepositId: $depositId");

                                          print("Amount: ${widget.amount}");

                                          // Create an instance of DepositData
                                          final depositData = DepositParams(
                                            amount: widget.amount.toInt(),
                                            methodOfFunding: selectedOptionName,
                                            sourceId: depositId,
                                          );

                                          NavigationService
                                              .navigateToDepositThird(
                                            context,
                                            depositData,
                                          );
                                        },
                                        child: const Text(AppTexts.deposit),
                                      ),
                                    ),
                                ],
                              );
                            } else {
                              return const SizedBox();
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
