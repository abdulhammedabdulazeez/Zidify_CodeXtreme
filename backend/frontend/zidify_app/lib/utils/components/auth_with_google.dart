import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/sizes.dart';
import '../constants/texts.dart';

class AuthWithGoogle extends StatelessWidget {
  const AuthWithGoogle({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          side: const BorderSide(
            color: AppColors.darkGrey,
            width: 1,
          ), // Border color and width
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.sm),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: AppSizes.iconMd,
              width: AppSizes.iconMd,
              child: Image(
                image: AssetImage(
                  AppTexts.googleIconPath,
                ),
              ),
            ),
            const SizedBox(width: AppSizes.sm),
            Text(
              text,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
