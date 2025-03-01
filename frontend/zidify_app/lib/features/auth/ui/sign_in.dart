import 'package:zidify_app/features/auth/domain_layer/bloc/auth_bloc.dart';
import 'package:zidify_app/features/auth/ui/widgets/signin_form.dart';
import 'package:zidify_app/service_locator.dart';
import 'package:zidify_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../utils/components/auth_bottom_route_text.dart';
import '../../../utils/components/auth_with_google.dart';
import '../../../utils/components/divider.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/texts.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthBloc>(instanceName: 'SigninBloc'),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is SigninLoadingState) {
            // Show a modal dialog with a loading spinner
            showDialog(
              context: context,
              barrierDismissible:
                  false, // Prevent dismissing by tapping outside
              builder: (BuildContext context) {
                return const Center(
                  child:
                      CircularProgressIndicator(), // You can also create a custom dialog here
                );
              },
            );
          } else {
            // Dismiss the dialog if loading is complete (whether success or failure)
            Navigator.of(context, rootNavigator: true)
                .pop(); // Close the loading dialog if it's open
          }
          if (state is SigninSucessState) {
            // Navigate to another screen on success
            context.go(AppTexts.homeRoute);

            // ScaffoldMessenger.of(context).showSnackBar(
            //   const SnackBar(content: Text('Yayyy!!!. Youre logged in!')),
            // );
          } else if (state is SigninFailureState) {
            // Show an error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
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
                              style:
                                  Theme.of(context).textTheme.headlineMedium),
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
        },
      ),
    );
  }
}
