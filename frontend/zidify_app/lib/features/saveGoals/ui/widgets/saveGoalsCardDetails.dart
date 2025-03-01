import 'package:zidify_app/utils/constants/colors.dart';
import 'package:zidify_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class SaveGoalsCardDetails extends StatelessWidget {
  final String label;
  final String value;
  const SaveGoalsCardDetails(
      {super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.black,
              ),
        ),
        const SizedBox(height: AppSizes.xs),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.savingsCard2,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
