import 'package:zidify_app/features/home/ui/widgets/my_savings.dart';
import 'package:zidify_app/utils/components/recent_activities.dart';
import 'package:zidify_app/features/home/ui/widgets/savings_tips.dart';
import 'package:zidify_app/features/user/domain_layer/bloc/user_bloc.dart';
import 'package:zidify_app/features/user/domain_layer/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:zidify_app/features/home/ui/widgets/todo.dart';
import 'package:zidify_app/features/home/ui/widgets/balances_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/texts.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/icons.dart';
import '../../../../utils/constants/images.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  bool _isBalanceHidden = true;
  void _toggleBalanceVisibility() {
    setState(() {
      _isBalanceHidden = !_isBalanceHidden;
    });
  }

  // Refresh function to reload user data
  Future<void> _refreshData() async {
    context.read<UserBloc>().add(OnFetchUserEvent());
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: _refreshData,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: AppSizes.appBarHeight,
                  left: AppSizes.defaultSpace,
                  bottom: AppSizes.defaultSpace,
                ),
                child: BlocConsumer<UserBloc, UserState>(
                  listener: (context, state) {
                    if (state is UserFetchErrorState) {
                      // Show error SnackBar on error
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.error),
                          ),
                        );
                      });
                    }
                  },
                  builder: (context, state) {
                    if (state is UserFetchLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is UserFetchErrorState) {
                      return const Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error,
                              size: 48,
                              color: Colors.red,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'An error occurred. Please try again.',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    } else if (state is UserFetchLoadedState) {
                      // Display the user data once loaded
                      final user = state.user;

                      return userLoadedContent(
                        user: user,
                        isBalanceHidden: _isBalanceHidden,
                        toggleBalanceVisibility: _toggleBalanceVisibility,
                        context: context,
                      );
                    } else {
                      return const Center(
                        child: Text("No user data available"),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Define your extracted UserLoadedContent widget function here
Widget userLoadedContent({
  required UserEntity user,
  required bool isBalanceHidden,
  required VoidCallback toggleBalanceVisibility,
  required BuildContext context,
}) {
  final balance = user.userSavingsTotal;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      // Greeting
      Padding(
        padding: const EdgeInsets.only(
          right: AppSizes.defaultSpace,
        ),
        child: Row(
          children: [
            const CircleAvatar(
              radius: AppSizes.imageThumbRadius,
              foregroundImage: AssetImage(AppImages.profileImage),
            ),
            const SizedBox(width: AppSizes.md),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.firstName,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  AppTexts.welcomeBack,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const Spacer(),
            const Icon(AppIcons.bellIcon, size: AppSizes.iconLg),
          ],
        ),
      ),
      const SizedBox(height: AppSizes.spaceBtwSections),

      // Total Savings
      Padding(
        padding: const EdgeInsets.only(right: AppSizes.spaceBtwItems),
        child: SizedBox(
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppTexts.totalSavingsBalance,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Row(
                    children: [
                      Text(
                        AppTexts.currency,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        isBalanceHidden
                            ? AppTexts.hiddenBalance // Hide balance
                            : balance.overallTotal
                                .toString(), // Use hidden state to display balance
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                icon: Icon(
                  isBalanceHidden
                      ? AppIcons.hiddenEyeIcon
                      : AppIcons.visibleEyeIcon,
                  size: AppSizes.iconMd,
                  color:
                      isBalanceHidden ? AppColors.darkGrey : AppColors.primary,
                ),
                onPressed: toggleBalanceVisibility,
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: AppSizes.spaceBtwItems),

      // Save Balances Carousel
      BalancesCard(
        isBalanceHidden: isBalanceHidden,
        toggleBalanceVisibility: toggleBalanceVisibility,
        user: user,
      ),

      const SizedBox(height: AppSizes.spaceBtwSections),

      //My To-dos
      Text(AppTexts.myToDos, style: Theme.of(context).textTheme.titleMedium),
      Text(
        AppTexts.finishSettingUpYourAccount,
        style: Theme.of(context).textTheme.bodySmall,
      ),
      const SizedBox(height: AppSizes.spaceBtwItemsSmall),
      TodoListWidget(),

      const SizedBox(height: AppSizes.spaceBtwSections),

      //My My Savings
      Text(AppTexts.mySavings, style: Theme.of(context).textTheme.titleMedium),
      const SizedBox(height: AppSizes.spaceBtwItemsSmall),
      MySavingsWidget(),
      const SizedBox(height: AppSizes.spaceBtwSections),

      // Savings Tips
      Padding(
        padding: const EdgeInsets.only(right: AppSizes.defaultSpace),
        child: Row(
          children: [
            Text(AppTexts.savingsTips,
                style: Theme.of(context).textTheme.titleMedium),
            const Spacer(),
            GestureDetector(
              onTap: () {
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (context) => SavingsTipsPage()));
                context.pushNamed(AppTexts.savingsTipsRouteName);
              },
              child: Text(
                AppTexts.seeMore,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppColors.dark,
                    decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: AppSizes.spaceBtwItemsSmall),
      SavingsTipsWidget(), // Savings Tips Widget
      const SizedBox(height: AppSizes.spaceBtwSections),

      //Recent Activities
      Text(AppTexts.recentActivities,
          style: Theme.of(context).textTheme.titleMedium),
      const SizedBox(height: AppSizes.spaceBtwItemsSmall),
      RecentActivityWidget(
        entity: user,
      ),
      const SizedBox(height: AppSizes.spaceBtwSections),
    ],
  );
}
