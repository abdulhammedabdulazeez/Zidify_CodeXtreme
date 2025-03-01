import 'package:zidify_app/features/home/ui/widgets/saving_tips_widget2.dart';
import 'package:zidify_app/utils/constants/sizes.dart';
import 'package:zidify_app/utils/constants/texts.dart';
import 'package:flutter/material.dart';

class SavingsTipsPage extends StatelessWidget {
  const SavingsTipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(AppTexts.savingsTips,
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: AppSizes.spaceBtwItemsSmall),
            SavingsTipsWidget2(),
          ]),
        ));
  }
}
