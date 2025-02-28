import 'package:zidify_app/utils/constants/colors.dart';
import 'package:zidify_app/utils/constants/texts.dart';
import 'package:flutter/material.dart';

class SingUpHeaderTexts extends StatelessWidget {
  const SingUpHeaderTexts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        /// LET'S GET STARTED
        Text(
          AppTexts.letsGetStarted,
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontWeight: FontWeight.w700),
        ),

        /// REGISTER TO START SAVING WITH AGAKESI
        RichText(
          text: TextSpan(
            text: AppTexts.registerToStartSavingWith,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: AppColors.darkGrey),
            children: const <InlineSpan>[
              TextSpan(
                text: AppTexts.zidify,
                style: TextStyle(color: AppColors.primary),
              ),
              TextSpan(text: AppTexts.today),
            ],
          ),
        )
      ],
    );
  }
}
