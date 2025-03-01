import 'package:flutter/material.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/texts.dart';
import '../../../../utils/constants/sizes.dart';

class SavingsTipsWidget extends StatelessWidget {
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

  SavingsTipsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes
          .savingsTipsCarouselHeight, // Set height for the horizontal list
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // Horizontal scrolling
        itemCount: savingstips.length,
        itemBuilder: (context, index) {
          String title = savingstips[index]['title'];
          String detail = savingstips[index]['detail'];
          // Color color = todolist[index]['color'];
          // IconData buttonIcon = todolist[index]['buttonIcon'];

          return Container(
            width: AppSizes.saveCarouselWidth, // Fixed width for each card
            margin: EdgeInsets.only(
                left: index == 0 ? 0 : 4), // Space between cards
            child: Card(
              color: AppColors.savingtipsCard,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.borderRadiusSm),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.white,
                          ),
                    ),
                    const SizedBox(
                      height: AppSizes.md,
                    ), // Add fixed height for spacing
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
        },
      ),
    );
  }
}
