import 'package:zidify_app/utils/components/transaction_input_tile.dart';
import 'package:zidify_app/utils/constants/colors.dart';
import 'package:zidify_app/utils/constants/navigation_params/nav_service.dart';
import 'package:zidify_app/utils/constants/sizes.dart';
import 'package:zidify_app/utils/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DepositFirstScreen extends StatefulWidget {
  const DepositFirstScreen({super.key});

  @override
  State<DepositFirstScreen> createState() => _DepositFirstScreenState();
}

class _DepositFirstScreenState extends State<DepositFirstScreen> {
  final TextEditingController _amountController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose(); // Dispose controller to avoid memory leaks
    super.dispose();
  }

  void _navigateToNextScreen() {
    // Validate and get input text
    final amountText = _amountController.text.trim();
    final amount = double.tryParse(amountText);

    // Handle invalid input
    if (amount == null || amount <= 0) {
      // Display error message or validation logic
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid amount')),
      );
      return;
    }

    // Clear the input field
    _amountController.clear();

    NavigationService.navigateToDepositSecond(context, amount);
    // context.go(
    //   '${AppTexts.savingsRoute}${AppTexts.saveBoxRoute}${AppTexts.depositFirstScreenRoute}${AppTexts.depositSecondScreenRoute}',
    //   extra: DepositSecondScreenParams(amount: 100.0),
    // );
  }

  // String navigateDepositRoute() {
  //   return '${AppTexts.savingsRoute}${AppTexts.saveBoxRoute}${AppTexts.depositFirstScreenRoute}${AppTexts.depositSecondScreenRoute}';
  // }

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
                'Step 1 of 2',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppColors.darkGrey),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(top: AppSizes.spaceBtwSections),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppTexts.quickSave,
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

                  // AMOUNT INPUT
                  TransactionInputTile(
                    headerText: AppTexts.enterAmount,
                    hintText: null,
                    controller: _amountController,
                  ),
                  const SizedBox(height: AppSizes.xl),

                  // CONTINUE
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _navigateToNextScreen,
                      child: const Text(AppTexts.contnue),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
