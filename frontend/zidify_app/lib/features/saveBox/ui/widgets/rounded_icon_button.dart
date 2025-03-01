import 'package:zidify_app/utils/constants/colors.dart';
import 'package:zidify_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class RoundedIconButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const RoundedIconButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.all(AppSizes.md),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.lightGreyContainer,
            ),
            child: Icon(
              icon,
              color: const Color.fromARGB(255, 92, 92, 92),
              size: AppSizes.iconLg,
            ),
          ),
        ),
        const SizedBox(height: AppSizes.sm),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
