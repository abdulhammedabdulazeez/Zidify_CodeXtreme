import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/colors.dart';
import '../constants/sizes.dart';

class AuthBottomRouteText extends StatelessWidget {
  const AuthBottomRouteText({
    super.key,
    required this.mainText,
    required this.authText,
    required this.authRoute,
  });

  final String mainText;
  final String authText;
  final String authRoute;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          mainText,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: AppColors.darkerGrey),
        ),
        const SizedBox(width: AppSizes.xs),

        /// SIGNUP TEXT
        GestureDetector(
          onTap: () async {
            context.go(authRoute);
          },
          child: Text(
            authText,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: AppColors.primary),
          ),
        ),
      ],
    );
  }
}
