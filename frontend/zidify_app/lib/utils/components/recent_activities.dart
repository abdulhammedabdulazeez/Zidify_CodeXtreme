// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:zidify_app/features/saveBox/domain_layer/entities/savebox_entity.dart';
import 'package:zidify_app/utils/constants/texts.dart';
import 'package:flutter/material.dart';

import 'package:zidify_app/features/user/domain_layer/entities/user_entity.dart';

import '../constants/colors.dart';
import '../constants/sizes.dart';

import 'package:timeago/timeago.dart' as timeago;

class RecentActivityWidget extends StatelessWidget {
  final dynamic entity;

  const RecentActivityWidget({
    super.key,
    required this.entity,
  });

  @override
  Widget build(BuildContext context) {
    List<dynamic> activities;

    if (entity is UserEntity) {
      activities = entity.activities;
    } else if (entity is SaveboxEntity) {
      activities = entity.activities;
    } else {
      activities = [];
    }

    return Padding(
      padding: const EdgeInsets.only(right: AppSizes.defaultSpace),
      child: Container(
        margin: const EdgeInsets.only(bottom: 35),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
          border: activities.isNotEmpty
              ? Border.all(
                  color: AppColors.black, // Border color
                  width: 1,
                )
              : null,
        ),
        padding: const EdgeInsets.only(top: AppSizes.md),
        child: activities.isEmpty
            ? const Center(
                child: Text(
                  AppTexts.noRecentActivity,
                  style: TextStyle(color: AppColors.darkGrey),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: activities.map((activity) {
                  return Column(
                    children: [
                      RecentActivityItem(
                        title: activity.description,
                        amount: activity.amount.toString(),
                        time: activity.createdAt,
                      ),
                      const Divider(
                          // height: AppSizes.dividerHeight,
                          ),
                    ],
                  );
                }).toList(),
              ),
      ),
    );
  }
}

class RecentActivityItem extends StatelessWidget {
  final String title;
  final String amount;
  final DateTime time;

  const RecentActivityItem({
    super.key,
    required this.title,
    required this.amount,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    // Format time as relative time
    final String relativeTime = timeago.format(time, locale: 'en');

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: title == 'Withdrawal' || title == 'Deposit'
            ? AppColors.white
            : AppColors.grey,
        child: title == 'Withdrawal'
            ? const Icon(
                Icons.arrow_downward,
                color: Colors.red,
              )
            : title == 'Deposit'
                ? const Icon(
                    Icons.arrow_upward,
                    color: Colors.green,
                  )
                : null, // Placeholder color for avatar
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            relativeTime,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: Colors.grey), // Style for time
          ),
        ],
      ),
      trailing: ConstrainedBox(
        constraints: const BoxConstraints(
            minWidth: 0, maxWidth: 100), // Adjust width as needed
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppTexts.currency,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              amount,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
