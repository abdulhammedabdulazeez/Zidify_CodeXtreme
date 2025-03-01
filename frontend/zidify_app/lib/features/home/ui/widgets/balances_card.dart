import 'package:zidify_app/features/user/domain_layer/entities/user_entity.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/texts.dart';
import '../../../../../utils/constants/icons.dart';

class BalancesCard extends StatefulWidget {
  final bool isBalanceHidden;
  final VoidCallback toggleBalanceVisibility;
  final UserEntity user;

  const BalancesCard({
    super.key,
    required this.isBalanceHidden,
    required this.toggleBalanceVisibility,
    required this.user,
  });

  @override
  _BalancesCardState createState() => _BalancesCardState();
}

class _BalancesCardState extends State<BalancesCard> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 0;
  late List<Map<String, dynamic>> balancescard;

  @override
  void initState() {
    super.initState();
    balancescard = [
      {
        'title': AppTexts.saveBoxBalance,
        'balance': widget.user.userSavingsTotal.totalSaveBox.toString(),
        'color': AppColors.primary,
        'depositButtonIcon': AppIcons.depositIcon,
        'depositButtonText': AppTexts.buttonTextDeposit,
      },
      {
        'title': AppTexts.saveGoalsBalance,
        'balance': widget.user.userSavingsTotal.totalSaveGoals.toString(),
        'color': AppColors.savingsCard2,
      },
      {
        'title': AppTexts.lockBoxBalance,
        'balance': widget.user.userSavingsTotal.totalLockBoxes.toString(),
        'color': AppColors.tertiary,
      },
    ];

    _scrollController.addListener(() {
      int page =
          (_scrollController.offset / AppSizes.saveCarouselWidth).round();
      if (page != _currentPage) {
        setState(() {
          _currentPage = page.clamp(0, balancescard.length - 1);
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height:
              AppSizes.saveCarouselHeight, // Set height for the horizontal list
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollNotification) {
              if (scrollNotification.metrics.axis == Axis.horizontal) {
                int page =
                    (_scrollController.offset / AppSizes.saveCarouselWidth)
                        .round();
                setState(() {
                  _currentPage = page.clamp(0, balancescard.length - 1);
                });
              }
              return true;
            },
            child: ListView.builder(
              controller: _scrollController,
              // physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: balancescard.length,
              itemBuilder: (context, index) {
                String title = balancescard[index]['title'];
                String balance = balancescard[index]['balance'];
                Color color = balancescard[index]['color'];

                return Container(
                  width:
                      AppSizes.saveCarouselWidth, // Set the desired width here
                  margin: EdgeInsets.only(left: index == 0 ? 0.0 : 4),
                  child: Card(
                    color: color,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppSizes.cardRadiusMd),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(AppSizes.md),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: AppColors.white),
                          ),
                          const SizedBox(height: AppSizes.md),
                          Row(
                            children: [
                              Text(
                                widget.isBalanceHidden
                                    ? AppTexts.hiddenBalance
                                    : '$balance ',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      color: AppColors.white,
                                    ),
                              ),
                              Text(
                                AppTexts.currency,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: AppColors.white),
                              ),
                            ],
                          ),
                          if (balancescard[index]
                              .containsKey('depositButtonIcon')) ...[
                            const Spacer(),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: SizedBox(
                                height: AppSizes.carouselButtonHeight,
                                width: AppSizes.carouselButtonWidth,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    // Add button functionality
                                    // context.go(
                                    //   '${AppTexts.savingsRoute}${AppTexts.saveBoxRoute}${AppTexts.depositFirstScreenRoute}',
                                    // );
                                  },
                                  icon: Icon(
                                    balancescard[index]['depositButtonIcon'],
                                    size: AppSizes.iconSm,
                                  ),
                                  label: Text(
                                    balancescard[index]['depositButtonText'] ??
                                        '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(color: AppColors.white),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    side: const BorderSide(
                                        color: AppColors.black),
                                    backgroundColor: AppColors.black,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: AppSizes.xs,
                                        horizontal: AppSizes.sm),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),

        const SizedBox(height: AppSizes.spaceBtwItems),
        // Page Indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(balancescard.length, (index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              width: _currentPage == index ? 40.0 : 20,
              height: 6.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: _currentPage == index ? Colors.blue : Colors.grey,
                shape: BoxShape.rectangle,
              ),
            );
          }),
        ),
      ],
    );
  }
}
