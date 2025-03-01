// import 'package:zidify_app/features/auth/domain_layer/bloc/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zidify_app/features/auth/domain_layer/bloc/auth_bloc.dart';
import 'package:zidify_app/utils/constants/colors.dart';
import 'package:zidify_app/utils/constants/sizes.dart';
import 'package:zidify_app/utils/constants/texts.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class SignInFormView extends StatefulWidget {
  const SignInFormView({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  State<SignInFormView> createState() => _SignInFormViewState();
}

class _SignInFormViewState extends State<SignInFormView> {
  late final TextEditingController _emailTextController;
  late final TextEditingController _passwordTextController;

  final _formField = GlobalKey<FormState>();

  bool isObscured = true;

  @override
  void initState() {
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  void onSubmit() {
    if (_formField.currentState!.validate()) {
      _formField.currentState!.save();

      BlocProvider.of<AuthBloc>(context).add(OnLoginButtonClickedAuthEvent(
        email: _emailTextController.text,
        password: _passwordTextController.text,
      ));

    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formField,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          /// EMAIL
          Padding(
            padding: const EdgeInsets.only(bottom: AppSizes.sm),
            child: Text(AppTexts.email,
                style: Theme.of(context).textTheme.bodyLarge),
          ),
          TextFormField(
            controller: _emailTextController,
            decoration: InputDecoration(
                hintText: AppTexts.enterYourEmailAddress,
                hintStyle: Theme.of(context).textTheme.bodySmall),
            validator: (value) {
              if (value == null ||
                  value.trim().isEmpty ||
                  !value.contains('@')) {
                return 'Please enter a valid email address';
              }

              return null;
            },
            onSaved: (value) => value = _emailTextController.text,
          ),
          const SizedBox(height: AppSizes.spaceBtwItems),

          /// PASSWORD
          Padding(
            padding: const EdgeInsets.only(bottom: AppSizes.sm),
            child: Text(
              AppTexts.password,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          TextFormField(
            controller: _passwordTextController,
            obscureText: isObscured,
            decoration: InputDecoration(
              hintText: AppTexts.enterYourPassword,
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: AppColors.darkGrey),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isObscured = !isObscured;
                  });
                },
                icon: isObscured
                    ? const Icon(Iconsax.eye_slash)
                    : const Icon(Iconsax.eye),
              ),
              suffixIconColor: const Color(0xFF9CA3AF),
            ),
            onSaved: (value) => value = _passwordTextController.text,
          ),

          /// FORGOT PASSWORD?
          Padding(
            padding: const EdgeInsets.only(top: AppSizes.sm),
            child: GestureDetector(
              onTap: () async {
                await Navigator.of(context).pushNamed(AppTexts.forgotPswdRoute);
              },
              child: Align(
                alignment: Alignment.topRight,
                child: Text(
                  AppTexts.forgotPassword,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: AppColors.primary),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSizes.spaceBtwSections),

          /// LOGIN BUTTON
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onSubmit,
              child: Text(AppTexts.login,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: AppColors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
