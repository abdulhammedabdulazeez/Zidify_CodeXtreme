import 'package:flutter/material.dart';
import 'package:zidify_app/features/auth/ui/widgets/signup_header.dart';
// import 'package:zidify_app/utils/constants/colors.dart';

import '../../../utils/components/auth_bottom_route_text.dart';
import '../../../utils/components/auth_with_google.dart';
import '../../../utils/components/divider.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/texts.dart';
import 'widgets/signup_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(
              AppSizes.defaultSpace,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                /// HEADER TEXTS
                SingUpHeaderTexts(),
                SizedBox(height: AppSizes.spaceBtwItems),

                /// SIGN UN FORM VIEW
                SignUpFormView(),
                SizedBox(height: AppSizes.spaceBtwSections),

                /// OR WITH DIVIDER
                DividerWidget(text: AppTexts.or),
                SizedBox(height: AppSizes.spaceBtwSections),

                /// SIGN UP WITH GOOGLE
                AuthWithGoogle(text: AppTexts.signUpWithGoogle),
                SizedBox(height: AppSizes.spaceBtwSections),

                /// HAVE AN ACCOUNT? LOGIN
                AuthBottomRouteText(
                  mainText: AppTexts.haveAnAccount,
                  authText: AppTexts.login,
                  authRoute: AppTexts.signinRoute,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
