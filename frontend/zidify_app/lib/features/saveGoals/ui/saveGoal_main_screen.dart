import 'package:zidify_app/features/saveGoals/ui/widgets/GoalsList.dart';
import 'package:zidify_app/features/user/domain_layer/bloc/user_bloc.dart';
import 'package:zidify_app/utils/constants/colors.dart';
import 'package:zidify_app/utils/constants/sizes.dart';
import 'package:zidify_app/utils/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavegoalMainScreen extends StatefulWidget {
  const SavegoalMainScreen({super.key});

  @override
  State<SavegoalMainScreen> createState() => _SavegoalMainScreenState();
}

class _SavegoalMainScreenState extends State<SavegoalMainScreen> {
  @override
  Widget build(BuildContext context) {
    // Dispatch the event to fetch user data
    context.read<UserBloc>().add(OnFetchUserEvent());

    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          floatingActionButton: Container(
            constraints: const BoxConstraints.tightFor(
              width: 65.0, // Set the width
              height: 65.0, // Set the height
            ),
            child: FloatingActionButton(
              onPressed: () {
                // Define the action when the button is pressed
              },
              backgroundColor: AppColors.savingsCard2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0), // Make it round
              ),
              child: const Icon(
                Icons.add,
                color: AppColors.white,
                size: 40.0,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppSizes.md,
              horizontal: AppSizes.md,
            ),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: AppSizes.saveCarouselHeight,
                  child: Card(
                    color: AppColors.savingsCard2,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppSizes.cardRadiusMd),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSizes.lg,
                        horizontal: AppSizes.md,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppTexts.saveGoalsBalance,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: AppColors.grey,
                                ),
                          ),
                          const SizedBox(height: AppSizes.spaceBtwItems),
                          Row(
                            children: [
                              Builder(builder: (context) {
                                final balance = context.select<UserBloc, int?>(
                                  (userBloc) {
                                    final state = userBloc.state;
                                    if (state is UserFetchLoadedState) {
                                      return state
                                          .user.userSavingsTotal.totalSaveGoals;
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
                              }),
                              const SizedBox(width: 6),
                              Text(
                                AppTexts.currency,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(color: AppColors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSizes.spaceBtwItems),

                // GOALS DEFINITION SECTION

                SizedBox(
                  width: double.infinity,
                  child: Card(
                    color: AppColors.mySavingsCard2,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppSizes.cardRadiusMd),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSizes.lg,
                        horizontal: AppSizes.md,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppTexts.saveGoaldef,
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          const SizedBox(height: AppSizes.spaceBtwItemsSmall),
                          Text(
                            AppTexts.saveGoalsDetails,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: AppColors.secondary),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: AppSizes.spaceBtwItems),

                // TABS SECTION

                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: AppSizes.md),
                  child: TabBar(
                    labelColor: AppColors.black,
                    unselectedLabelColor: AppColors.black,
                    indicatorColor: AppColors.savingsCard2,
                    // dividerColor: Colors.transparent,
                    labelStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: AppSizes.fontSizeLg,
                        ),
                    tabs:  [
                      Tab(
                        text: AppTexts.ongoingSaveGoals,
                      ),
                      Tab(
                        text: AppTexts.completedSaveGoals,
                      ),
                    ],
                  ),
                ),

                // TabBarView
                Expanded(
                  child: TabBarView(
                    children: [
                      GoalsList(savingsList: savingsList),
                      GoalsList(savingsList: completedSavingsList),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final List<Map<String, dynamic>> completedSavingsList = [
  {
    "savingsTitle": "Vacation Fund",
    "amountSaved": 3000,
    "targetAmount": 3000,
    "daysLeft": 0,
    "savingsPercentage": 100,
    "imagePath": "assets/images/vacation.png",
    "status": "completed",
  },
  {
    "savingsTitle": "Emergency Fund",
    "amountSaved": 5000,
    "targetAmount": 5000,
    "daysLeft": 0,
    "savingsPercentage": 100,
    "imagePath": "assets/images/emergency.png",
    "status": "completed",
  },
  {
    "savingsTitle": "Car Down Payment",
    "amountSaved": 10000,
    "targetAmount": 10000,
    "daysLeft": 0,
    "savingsPercentage": 100,
    "imagePath": "assets/images/car.png",
    "status": "completed",
  },
  {
    "savingsTitle": "House Rent",
    "amountSaved": 30000,
    "targetAmount": 30000,
    "daysLeft": 0,
    "savingsPercentage": 100,
    "imagePath": "assets/images/house.png",
    "status": "completed",
  },
  {
    "savingsTitle": "Wedding Fund",
    "amountSaved": 10000,
    "targetAmount": 10000,
    "daysLeft": 0,
    "savingsPercentage": 100,
    "imagePath": "assets/images/wedding.png",
    "status": "completed",
  },
  {
    "savingsTitle": "Education Fund",
    "amountSaved": 20000,
    "targetAmount": 20000,
    "daysLeft": 0,
    "savingsPercentage": 100,
    "imagePath": "assets/images/education.png",
    "status": "completed",
  },
  {
    "savingsTitle": "Business Capital",
    "amountSaved": 100000,
    "targetAmount": 100000,
    "daysLeft": 0,
    "savingsPercentage": 100,
    "imagePath": "assets/images/business.png",
    "status": "completed",
  },
  {
    "savingsTitle": "Investment Fund",
    "amountSaved": 100000,
    "targetAmount": 100000,
    "daysLeft": 0,
    "savingsPercentage": 100,
    "imagePath": "assets/images/investment.png",
    "status": "completed",
  },
  {
    "savingsTitle": "Health Fund",
    "amountSaved": 10000,
    "targetAmount": 10000,
    "daysLeft": 0,
    "savingsPercentage": 100,
    "imagePath": "assets/images/health.png",
    "status": "completed",
  },
  {
    "savingsTitle": "Charity Fund",
    "amountSaved": 10000,
    "targetAmount": 10000,
    "daysLeft": 0,
    "savingsPercentage": 100,
    "imagePath": "assets/images/charity.png",
    "status": "completed",
  },
];

final List<Map<String, dynamic>> savingsList = [
  {
    "savingsTitle": "Vacation Fund",
    "amountSaved": 1500,
    "targetAmount": 3000,
    "daysLeft": 60,
    "savingsPercentage": 50,
    "imagePath": "assets/images/vacation.png",
    "status": "ongoing",
  },
  {
    "savingsTitle": "Emergency Fund",
    "amountSaved": 2500,
    "targetAmount": 5000,
    "daysLeft": 90,
    "savingsPercentage": 50,
    "imagePath": "assets/images/emergency.png",
    "status": "ongoing",
  },
  {
    "savingsTitle": "Car Down Payment",
    "amountSaved": 8000,
    "targetAmount": 10000,
    "daysLeft": 120,
    "savingsPercentage": 80,
    "imagePath": "assets/images/car.png",
    "status": "ongoing",
  },
  {
    "savingsTitle": "House Rent",
    "amountSaved": 20000,
    "targetAmount": 30000,
    "daysLeft": 180,
    "savingsPercentage": 66.67,
    "imagePath": "assets/images/house.png",
    "status": "ongoing",
  },
  {
    "savingsTitle": "Wedding Fund",
    "amountSaved": 5000,
    "targetAmount": 10000,
    "daysLeft": 90,
    "savingsPercentage": 50,
    "imagePath": "assets/images/wedding.png",
    "status": "ongoing",
  },
  {
    "savingsTitle": "Education Fund",
    "amountSaved": 10000,
    "targetAmount": 20000,
    "daysLeft": 120,
    "savingsPercentage": 50,
    "imagePath": "assets/images/education.png",
    "status": "ongoing",
  },
  {
    "savingsTitle": "Business Capital",
    "amountSaved": 50000,
    "targetAmount": 100000,
    "daysLeft": 180,
    "savingsPercentage": 50,
    "imagePath": "assets/images/business.png",
    "status": "ongoing",
  },
  {
    "savingsTitle": "Investment Fund",
    "amountSaved": 50000,
    "targetAmount": 100000,
    "daysLeft": 180,
    "savingsPercentage": 50,
    "imagePath": "assets/images/investment.png",
    "status": "ongoing",
  },
  {
    "savingsTitle": "Health Fund",
    "amountSaved": 5000,
    "targetAmount": 10000,
    "daysLeft": 90,
    "savingsPercentage": 50,
    "imagePath": "assets/images/health.png",
    "status": "ongoing",
  },
  {
    "savingsTitle": "Charity Fund",
    "amountSaved": 5000,
    "targetAmount": 10000,
    "daysLeft": 90,
    "savingsPercentage": 50,
    "imagePath": "assets/images/charity.png",
    "status": "ongoing",
  },
];
