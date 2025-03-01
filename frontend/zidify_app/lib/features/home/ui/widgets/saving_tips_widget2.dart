import 'package:zidify_app/utils/constants/colors.dart';
import 'package:zidify_app/utils/constants/sizes.dart';
import 'package:zidify_app/utils/constants/texts.dart';
import 'package:flutter/material.dart';

class SavingsTipsWidget2 extends StatelessWidget {
  final List<Map<String, dynamic>> savingstips = [
    {
      'title': AppTexts.savingsTipTitle1,
      'detail': AppTexts.savingsTipsDetails1,
    },
    {
      'title': AppTexts.savingsTipTitle2,
      'detail': AppTexts.savingsTipsDetails2,
    },
    {
      'title': AppTexts.savingsTipTitle3,
      'detail': AppTexts.savingsTipsDetails3,
    },
  ];

  SavingsTipsWidget2({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: savingstips.map((tip) {
          String title = tip['title'];
          String detail = tip['detail'];

          return Container(
            // width: AppSizes.saveCarouselWidth, // Fixed width for each card
            margin: const EdgeInsets.only(
                bottom: AppSizes.defaultSpace), // Space between cards
            child: Card(
              color: AppColors.savingtipsCard,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.borderRadiusSm),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      // Use a Center widget to center the text horizontally
                      child: Text(
                        title,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: AppColors.white,
                                ),
                      ),
                    ),
                    const SizedBox(
                        height: AppSizes.md), // Fixed height for spacing
                    Text(
                      detail,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.white,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
