import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/texts.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/images.dart';

class MySavingsWidget extends StatelessWidget {
  MySavingsWidget({super.key});

  final List<Map<String, dynamic>> mysavings = [
    {
      'title': AppTexts.saveBox,
      'detail': AppTexts.saveBoxDetails,
      'buttonColor': AppColors.mySavingsButton1,
      'backgroundColor': AppColors.mySavingsCard1,
      'buttonText': AppTexts.saveNow,
      'image': AppImages.saveboxCarousel1, // Path to your image
    },
    {
      'title': AppTexts.saveGoals,
      'detail': AppTexts.saveGoalsDetails,
      'buttonColor': AppColors.mySavingsButton2,
      'backgroundColor': AppColors.mySavingsCard2,
      'buttonText': AppTexts.saveNow,
      'image': 'assets/images/save_goals.png', // Path to your image
    },
    {
      'title': AppTexts.lockBox,
      'detail': AppTexts.lockBoxDetails,
      'buttonColor': AppColors.mySavingsButton3,
      'backgroundColor': AppColors.mySavingsCard3,
      'buttonText': AppTexts.lockNow,
      'image': 'assets/images/lock_box.png', // Path to your image
    },
  ];

  void navigateBasedOnIndex(BuildContext context, int index) {
    switch (index) {
      case 0:
        // Navigate to Page1
        context.go('${AppTexts.savingsRoute}${AppTexts.saveBoxRoute}');
        break;
      case 1:
        // Navigate to Page2
        context.go('${AppTexts.savingsRoute}${AppTexts.saveGoalRoute}');
        break;
      case 2:
        // Navigate to Page3
        context.go(AppTexts.saveBoxRouteName);
        break;
      default:
        // Default page or handle cases not covered above
        context.go(AppTexts.saveBoxRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: AppSizes.defaultSpace),
      child: Column(
        children: List.generate(mysavings.length, (index) {
          String title = mysavings[index]['title'];
          String details = mysavings[index]['detail'];
          Color buttonColor = mysavings[index]['buttonColor'];
          Color backgroundColor = mysavings[index]['backgroundColor'];
          String buttonText = mysavings[index]['buttonText'];
          String imagePath = mysavings[index]['image'];

          return Container(
            height: AppSizes.mySavingsCarouselHeight, // Set height for the card

            margin: EdgeInsets.only(
                top: index == 0 ? 0.0 : 12), // No space before the first card
            child: Card(
              color: backgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
              ),
              child: Stack(
                children: [
                  // Positioned image at the top right corner
                  Positioned(
                    top: 14,
                    right: -50,
                    child: Image.asset(
                      imagePath,
                      height: 210, // Set the height of the image
                      width: 210, // Set the width of the image
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: AppSizes.lg, horizontal: AppSizes.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: AppColors.black,
                                  ),
                        ),
                        const SizedBox(height: AppSizes.sm),
                        Text(
                          details,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.black,
                                  ),
                        ),
                        const Spacer(),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: SizedBox(
                            height: AppSizes.carouselButtonHeight,
                            width: AppSizes.carouselButtonWidth,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                navigateBasedOnIndex(context, index);
                              },
                              label: Text(
                                buttonText,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: AppColors.white,
                                    ),
                              ),
                              style: ElevatedButton.styleFrom(
                                side: const BorderSide(color: AppColors.black),
                                backgroundColor: buttonColor,
                                padding: const EdgeInsets.symmetric(
                                    vertical: AppSizes.xs,
                                    horizontal: AppSizes.sm),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
