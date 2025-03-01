import 'package:zidify_app/utils/components/recent_activities.dart';
import 'package:zidify_app/features/saveBox/domain_layer/entities/savebox_entity.dart';
import 'package:zidify_app/features/saveBox/ui/widgets/rounded_icon_button.dart';
import 'package:zidify_app/utils/constants/colors.dart';
import 'package:zidify_app/utils/constants/icons.dart';
import 'package:zidify_app/utils/constants/sizes.dart';
import 'package:zidify_app/utils/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class SaveBoxLoadedWidget extends StatefulWidget {
  final SaveboxEntity saveBox;

  const SaveBoxLoadedWidget({super.key, required this.saveBox});

  @override
  State<SaveBoxLoadedWidget> createState() => _SaveBoxLoadedWidgetState();
}

class _SaveBoxLoadedWidgetState extends State<SaveBoxLoadedWidget> {
  bool _isAutoSaveEnabled = false;

  String navigateWithdrawRoute() {
    return '${AppTexts.savingsRoute}${AppTexts.saveBoxRoute}${AppTexts.withdrawFirstScreenRoute}';
  }

  String navigateDepositRoute() {
    return '${AppTexts.savingsRoute}${AppTexts.saveBoxRoute}${AppTexts.depositFirstScreenRoute}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          // height: AppSizes.saveCarouselHeight,
          width: double.infinity,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
              color: AppColors.primary,
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
                    AppTexts.saveBoxBalance,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: AppColors.grey),
                  ),
                  const SizedBox(height: AppSizes.spaceBtwItems),
                  Row(
                    children: [
                      Text(
                        widget.saveBox.balance.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(color: AppColors.white),
                      ),
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
                  const SizedBox(height: AppSizes.defaultSpace),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.saveBox.accountNumber,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: AppColors.white),
                          ),
                          // const SizedBox(height: AppSizes.spaceBtwItemsSmall),
                          Text(
                            widget.saveBox.accountName,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: AppColors.grey),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: SizedBox(
                          // height: 30,
                          // width: 70,
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              await Clipboard.setData(
                                const ClipboardData(
                                    text: AppTexts.accountNumber),
                              );
                              // Show "Copied!" message
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Copied!'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }
                            },
                            label: Text(
                              'Copy',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: AppColors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              side: const BorderSide(color: AppColors.black),
                              backgroundColor: AppColors.black,
                              minimumSize: const Size(0, 24),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),

        // Enable auto save switch
        const SizedBox(height: AppSizes.spaceBtwSections),
        SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: AppSizes.md,
                  horizontal: AppSizes.md,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    AppSizes.borderRadiusMd,
                  ),
                  color: AppColors.lightGreyContainer,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppTexts.enableAutoSave,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: AppColors.dark),
                    ),
                    Switch(
                      value: _isAutoSaveEnabled,
                      onChanged: (bool newValue) {
                        setState(() {
                          _isAutoSaveEnabled = newValue;
                        });
                      },
                      activeTrackColor: AppColors.primary.withOpacity(0.5),
                      inactiveTrackColor: AppColors.darkGrey,
                      activeColor: AppColors.primary,
                      inactiveThumbColor: AppColors.white,
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                    ),
                  ],
                ),
              ),
              // const SizedBox(height: AppSizes.spaceBtwItems),
              Container(
                // width: ,
                padding: const EdgeInsets.symmetric(
                  vertical: AppSizes.lg,
                  horizontal: AppSizes.md,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    AppSizes.borderRadiusMd,
                  ),
                  // color: AppColors.lightGreyContainer,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RoundedIconButton(
                      icon: AppIcons.withdrawIcon,
                      label: AppTexts.withdraw,
                      onPressed: () {
                        context.go(navigateWithdrawRoute());
                      },
                    ),
                    const SizedBox(width: AppSizes.spaceBtwItemsLarge),
                    RoundedIconButton(
                      icon: AppIcons.depositIcon,
                      label: AppTexts.buttonTextDeposit,
                      onPressed: () {
                        context.go(navigateDepositRoute());
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        // const Spacer(),

        // BEGINNING OF RECENT ACTIVITIES SECTION

        //Recent Activities
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppTexts.recentActivities,
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: AppSizes.spaceBtwItemsSmall),
              Expanded(
                child: SingleChildScrollView(
                  child: RecentActivityWidget(
                    entity: widget.saveBox,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
