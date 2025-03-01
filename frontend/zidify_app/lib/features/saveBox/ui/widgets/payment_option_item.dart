import 'package:zidify_app/features/saveBox/data_layer/models/fund_dests_sources.dart';
import 'package:zidify_app/features/saveBox/data_layer/models/funding_sources_models.dart';
import 'package:zidify_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class PaymentOption extends StatelessWidget {
  const PaymentOption(
      {super.key,
      required this.isSelected,
      required this.isMomo,
      required this.item});

  final bool isSelected;
  final bool isMomo;
  final FundingSource item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue.withOpacity(0.3) : AppColors.white,
        border: isSelected
            ? Border.all(color: Colors.blue)
            : const Border(
                bottom: BorderSide(color: AppColors.grey, width: 2.0),
              ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: !isMomo ? AppColors.primary : null,
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  isMomo ? "assets/images/momo_image.png" : "",
                ), // Replace with your image URL
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Name: ${isMomo ? item.momoName : item.cardHolder}"),
                Text(
                  "Account Number: ${isMomo ? item.momoNumber : item.cardNumber}",
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (item.cardExpiry != null) Text("Expiry: ${item.cardExpiry}"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WithdrawalPaymentOption extends StatelessWidget {
  const WithdrawalPaymentOption(
      {super.key,
      required this.isSelected,
      required this.isMomo,
      required this.item});

  final bool isSelected;
  final bool isMomo;
  final FundDestination item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue.withOpacity(0.3) : AppColors.white,
        border: isSelected
            ? Border.all(color: Colors.blue)
            : const Border(
                bottom: BorderSide(color: AppColors.grey, width: 2.0),
              ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: !isMomo ? AppColors.primary : null,
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  isMomo ? "assets/images/momo_image.png" : "",
                ), // Replace with your image URL
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Name: ${isMomo ? item.momoName : item.accountName}"),
                Text(
                  "Account Number: ${isMomo ? item.momoNumber : item.accountNumber}",
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // if (item.cardExpiry != null) Text("Expiry: ${item.cardExpiry}"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
