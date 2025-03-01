import 'package:zidify_app/features/user/domain_layer/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/texts.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/images.dart';

class SavingsScreen extends StatelessWidget {
  SavingsScreen({super.key});

  final List<Map<String, dynamic>> mysavings = [
    {
      'title': AppTexts.saveBox,
      'detail': AppTexts.saveBoxDetails,
      'buttonColor': AppColors.mySavingsButton1,
      'backgroundColor': AppColors.mySavingsCard1,
      'buttonText': AppTexts.saveNow,
      'image': AppImages.saveboxCarousel1,
    },
    {
      'title': AppTexts.saveGoals,
      'detail': AppTexts.saveGoalsDetails,
      'buttonColor': AppColors.mySavingsButton2,
      'backgroundColor': AppColors.mySavingsCard2,
      'buttonText': AppTexts.saveNow,
      'image': 'assets/images/save_goals.png',
    },
    {
      'title': AppTexts.lockBox,
      'detail': AppTexts.lockBoxDetails,
      'buttonColor': AppColors.mySavingsButton3,
      'backgroundColor': AppColors.mySavingsCard3,
      'buttonText': AppTexts.lockNow,
      'image': 'assets/images/lock_box.png',
    },
  ];

  void navigateBasedOnIndex(BuildContext context, int index) {
    switch (index) {
      case 0:
        // Navigate to Page1
        // context.go('${AppTexts.savingsRoute}${AppTexts.saveBoxRoute}');
        context.pushNamed(AppTexts.saveBoxRouteName);
        break;
      case 1:
        // Navigate to Page2
        // context.go(AppTexts.saveBoxRoute);
        context.pushNamed(AppTexts.saveGoalRouteName);
        break;
      case 2:
        // Navigate to Page3
        context.go(AppTexts.saveBoxRoute);
        break;
      default:
        // Default page or handle cases not covered above
        context.go(AppTexts.saveBoxRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Dispatch the event to fetch user data
    context.read<UserBloc>().add(OnFetchUserEvent());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: AppSizes.appBarHeight, bottom: 10),
        child: ListView(
          padding:
              const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
          children: [
            // Total Savings Balance Card
            SizedBox(
              height: AppSizes.savingsTipsCarouselHeight,
              width: double.infinity,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
                  color: AppColors.dark,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: AppSizes.lg, horizontal: AppSizes.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppTexts.totalSavingsBalance,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: AppColors.white),
                      ),
                      const SizedBox(height: AppSizes.spaceBtwItems),
                      Row(
                        children: [
                          Text(
                            AppTexts.currency,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: AppColors.white),
                          ),
                          Builder(
                            builder: (context) {
                              final balance = context.select<UserBloc, int?>(
                                (userBloc) {
                                  final state = userBloc.state;
                                  if (state is UserFetchLoadedState) {
                                    return state
                                        .user.userSavingsTotal.overallTotal;
                                  }
                                  // print(state);
                                  return null; // Indicate loading state
                                },
                              );
                              if (balance == null) {
                                return const CircularProgressIndicator(
                                  color: AppColors.white,
                                );
                              }
                              return Text(
                                balance.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(color: AppColors.white),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // const SizedBox(
            //     height: AppSizes.spaceBtwSections), // Space between sections

            // Other Savings Cards
            ListView.builder(
              physics:
                  const NeverScrollableScrollPhysics(), // Disable scrolling for the inner ListView
              shrinkWrap: true, // Make ListView take only the needed height
              itemCount: mysavings.length,
              itemBuilder: (context, index) {
                String title = mysavings[index]['title'];
                String details = mysavings[index]['detail'];
                Color buttonColor = mysavings[index]['buttonColor'];
                Color backgroundColor = mysavings[index]['backgroundColor'];
                String buttonText = mysavings[index]['buttonText'];
                String imagePath = mysavings[index]['image'];

                return Container(
                  height: AppSizes.mySavingsCarouselHeight,
                  margin: EdgeInsets.only(
                      top: index == 0
                          ? 0 // Space above the first item
                          : AppSizes.spaceBtwItemsSmall), // Space between cards
                  child: Card(
                    color: backgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppSizes.borderRadiusMd),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 14,
                          right: -50,
                          child: Image.asset(
                            imagePath,
                            height: 210,
                            width: 210,
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
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(color: AppColors.black),
                              ),
                              const SizedBox(height: AppSizes.sm),
                              Text(
                                details,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: AppColors.black),
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
                                          ?.copyWith(color: AppColors.white),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      side: const BorderSide(
                                          color: AppColors.black),
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
              },
            ),
          ],
        ),
      ),
    );
  }
}
