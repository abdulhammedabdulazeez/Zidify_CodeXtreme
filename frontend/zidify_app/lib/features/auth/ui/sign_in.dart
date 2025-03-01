import 'package:flutter/material.dart';
import 'package:zidify_app/features/auth/ui/widgets/signin_form.dart';
import 'package:zidify_app/utils/constants/colors.dart';

import '../../../utils/components/auth_bottom_route_text.dart';
import '../../../utils/components/auth_with_google.dart';
import '../../../utils/components/divider.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/texts.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(
              AppSizes.defaultSpace,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                /// WELCOME BACK
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppTexts.welcomeBack,
                        style: Theme.of(context).textTheme.headlineMedium),
                    Text(
                      AppTexts.welcomeBackExplore,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: AppColors.darkGrey),
                    )
                  ],
                ),
                const SizedBox(height: AppSizes.spaceBtwItems),

                /// SIGN IN FORM VIEW
                SignInFormView(context: context),
                const SizedBox(height: AppSizes.spaceBtwSections),

                /// OR WITH DIVIDER
                const DividerWidget(text: AppTexts.or),
                const SizedBox(height: AppSizes.spaceBtwSections),

                /// LOGIN WITH GOOGLE
                const AuthWithGoogle(text: AppTexts.loginWithGoogle),
                const SizedBox(height: AppSizes.spaceBtwSections),

                /// DON'T HAVE ACCOUNT? SIGNUP
                const AuthBottomRouteText(
                  mainText: AppTexts.dontHaveAnAccount,
                  authText: AppTexts.signup,
                  authRoute: AppTexts.signupRoute,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
