import 'package:zidify_app/features/auth/domain_layer/bloc/auth_bloc.dart';
import 'package:zidify_app/features/auth/ui/widgets/signup_form.dart';
import 'package:zidify_app/features/auth/ui/widgets/signup_header.dart';
import 'package:zidify_app/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../utils/components/auth_bottom_route_text.dart';
import '../../../utils/components/auth_with_google.dart';
import '../../../utils/components/divider.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/texts.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthBloc>(instanceName: 'SignupBloc'),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is SignupLoadingState) {
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
          if (state is SignupSucessState) {
            // Navigate to another screen on success
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Yayyy!!!')),
            );
            context.go(AppTexts.homeRoute);
          } else if (state is SignupFailureState) {
            // Show an error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
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
        },
      ),
    );
  }
}
