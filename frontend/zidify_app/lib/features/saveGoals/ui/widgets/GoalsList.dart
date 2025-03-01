import 'package:zidify_app/features/saveGoals/ui/widgets/saveGoalsCardDetails.dart';
import 'package:zidify_app/utils/constants/colors.dart';
import 'package:zidify_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class GoalsList extends StatelessWidget {
  final List<Map<String, dynamic>> savingsList;
  const GoalsList({super.key, required this.savingsList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // Add physics to control scroll behavior
      physics: const AlwaysScrollableScrollPhysics(),
      // Add padding to avoid content being hidden by FAB
      // padding: const EdgeInsets.only(bottom: 80),
      shrinkWrap: false,
      itemCount: savingsList.length,
      itemBuilder: (context, index) {
        String status = savingsList[index]['status'].toString().toLowerCase();
        return Card(
          margin: const EdgeInsets.only(bottom: 20),
          color: AppColors.mySavingsCard2,
          child: Padding(
            padding: const EdgeInsets.all(
                16), // Add padding around the entire content
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment
              //     .start, // Align items to the top
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Leading container (image placeholder)
                Container(
                  width: 100,
                  height: 100,
                  // No need to specify height - it will expand naturally
                  decoration: BoxDecoration(
                    color: AppColors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ), // Spacing between image and content

                // GOAL DETAIL SECTION
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Title
                      Text(
                        savingsList[index]['savingsTitle'],
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: AppColors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: AppSizes.fontSizeLg,
                            ),
                      ),
                      const SizedBox(height: AppSizes.spaceBtwItems),

                      // Savings details row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SaveGoalsCardDetails(
                            label: 'Saved',
                            value: savingsList[index]['amountSaved'].toString(),
                          ),
                          SaveGoalsCardDetails(
                            label: 'Total Target',
                            value:
                                savingsList[index]['targetAmount'].toString(),
                          ),
                          SaveGoalsCardDetails(
                            label: 'Days Left',
                            value: savingsList[index]['daysLeft'].toString(),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSizes.spaceBtwItems),

                      // Progress indicator

                      if (status == 'ongoing')
                        LinearPercentIndicator(
                          lineHeight: 14.0,
                          percent:
                              savingsList[index]['savingsPercentage'] / 100,
                          backgroundColor: AppColors.grey,
                          progressColor: AppColors.savingsCard2,
                          barRadius: const Radius.circular(15),
                          animation: true,
                          animateFromLastPercent: true,
                          animationDuration: 1500,
                          trailing: Text(
                            '${savingsList[index]['savingsPercentage'].toString()}%',
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: AppColors.savingsCard2,
                                      fontWeight: FontWeight.bold,
                                      fontSize: AppSizes.fontSizeLg,
                                    ),
                          ),
                        )
                      else if (status == 'completed')
                        Text(
                          'COMPLETED',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: AppColors.savingsCard2,
                                    fontWeight: FontWeight.bold,
                                    fontSize: AppSizes.fontSizeLg,
                                  ),
                        )
                      else
                        // Add a default case to help debug
                        const SizedBox
                            .shrink() // Return empty widget for unknown status
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
