// import 'package:zidify_app/features/auth/domain_layer/bloc/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zidify_app/features/auth/domain_layer/bloc/auth_bloc.dart';
import 'package:zidify_app/features/auth/ui/widgets/signup_input_tile.dart';
import 'package:zidify_app/utils/components/input_pswd_tile.dart';
import 'package:zidify_app/utils/constants/colors.dart';
import 'package:zidify_app/utils/constants/sizes.dart';
import 'package:zidify_app/utils/constants/texts.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpFormView extends StatefulWidget {
  const SignUpFormView({
    super.key,
  });

  @override
  State<SignUpFormView> createState() => _SignUpFormViewState();
}

class _SignUpFormViewState extends State<SignUpFormView> {
  late final TextEditingController _emailTextController;
  late final TextEditingController _passwordTextController;
  late final TextEditingController _confirmPasswordTextController;
  late final TextEditingController _firstNameTextController;
  late final TextEditingController _lastNameTextController;
  late final TextEditingController _phoneNumberTextController;

  final _formField = GlobalKey<FormState>();

  bool pswdIsObscured = true;
  bool confirmPswdIsObscured = true;
  bool isChecked = false;

  @override
  void initState() {
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    _confirmPasswordTextController = TextEditingController();
    _firstNameTextController = TextEditingController();
    _lastNameTextController = TextEditingController();
    _phoneNumberTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _confirmPasswordTextController.dispose();
    _firstNameTextController.dispose();
    _lastNameTextController.dispose();
    _phoneNumberTextController.dispose();
    super.dispose();
  }

  void toggleObscurePswdText() {
    setState(() {
      pswdIsObscured = !pswdIsObscured;
    });
  }

  void toggleObscureConfirmPswdText() {
    setState(() {
      confirmPswdIsObscured = !confirmPswdIsObscured;
    });
  }

  void createAccount() {
    if (_formField.currentState!.validate()) {
      _formField.currentState!.save();

      BlocProvider.of<AuthBloc>(context).add(OnSignupSubmitAuthEvent(
        email: _emailTextController.text,
        firstName: _firstNameTextController.text,
        lastName: _lastNameTextController.text,
        password: _passwordTextController.text,
        phoneNumber: _phoneNumberTextController.text,
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
          /// FIRST NAME
          SignUpInputTile(
            controller: _firstNameTextController,
            headerText: AppTexts.firstname,
            hintText: AppTexts.enterYourLastName,
            validator: (value) {
              if (value == null || value.trim().isEmpty || value.length < 2) {
                return 'The provided character must be more than 2';
              }

              return null;
            },
            onSaved: (value) => value = _firstNameTextController.text,
          ),
          const SizedBox(height: AppSizes.spaceBtwItems),

          /// LAST NAME
          SignUpInputTile(
            controller: _lastNameTextController,
            headerText: AppTexts.lastname,
            hintText: AppTexts.enterYourLastName,
            validator: (value) {
              if (value == null || value.trim().isEmpty || value.length < 2) {
                return 'The provided character must be more than 2';
              }

              return null;
            },
            onSaved: (value) => value = _lastNameTextController.text,
          ),
          const SizedBox(height: AppSizes.spaceBtwItems),

          /// EMAIL
          SignUpInputTile(
            controller: _emailTextController,
            headerText: AppTexts.email,
            hintText: AppTexts.enterYourEmailAddress,
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

          /// PHONE NUMBER
          SignUpInputTile(
            controller: _phoneNumberTextController,
            headerText: AppTexts.phoneNumber,
            hintText: AppTexts.enterYourPhoneNumber,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your phone number';
              }

              // Use a regex to check if the phone number contains only digits
              final phoneRegExp = RegExp(r'^[0-9]+$');

              if (!phoneRegExp.hasMatch(value)) {
                return 'Please enter a valid phone number with only digits';
              }

              if (value.length != 10) {
                return 'Please enter a valid 10-digit phone number';
              }

              return null;
            },
            onSaved: (value) => value = _phoneNumberTextController.text,
          ),
          const SizedBox(height: AppSizes.spaceBtwItems),

          /// PASSWORD
          InputPasswordTile(
            headerText: AppTexts.password,
            hintText: AppTexts.enterYourPassword,
            isObscured: pswdIsObscured,
            toggleObscureText: toggleObscurePswdText,
            controller: _passwordTextController,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter a password';
              }

              if (value.length < 8) {
                return 'Password must be at least 8 characters long';
              }

              // Ensure the password contains at least one uppercase letter, one lowercase letter, and one number
              // final passwordRegExp =
              //     RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$');
              // if (!passwordRegExp.hasMatch(value)) {
              //   return 'Password must contain at least one uppercase letter, one lowercase letter, and one number';
              // }

              return null;
            },
            onSaved: (value) => value = _passwordTextController.text,
          ),
          const SizedBox(height: AppSizes.spaceBtwItems),

          /// CONFIRM PASSWORD
          InputPasswordTile(
            headerText: AppTexts.confirmPassword,
            hintText: AppTexts.retypeYourPassword,
            isObscured: confirmPswdIsObscured,
            toggleObscureText: toggleObscureConfirmPswdText,
            controller: _confirmPasswordTextController,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please confirm your password';
              }

              if (value != _passwordTextController.text) {
                return 'Passwords do not match';
              }

              return null;
            },
            onSaved: (value) => value = _confirmPasswordTextController.text,
          ),

          /// TERMS AND PRIVACY POLICY
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              /// CHECKBOX
              Checkbox(
                value: isChecked,
                onChanged: (bool? value) {
                  setState(
                    () {
                      isChecked = value!;
                    },
                  );
                },
              ),

              /// TERM OF SERVICE AND PRIVACY TEXT
              Expanded(
                child: RichText(
                  text: TextSpan(
                    text: AppTexts.iAgreeToTheCompany,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: AppColors.darkGrey),
                    children: const <InlineSpan>[
                      TextSpan(
                        text: AppTexts.termOfService,
                        style: TextStyle(color: AppColors.primary),
                      ),
                      TextSpan(text: AppTexts.and),
                      TextSpan(
                        text: AppTexts.privacyPolicy,
                        style: TextStyle(color: AppColors.primary),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: AppSizes.spaceBtwItems),

          /// CREATE AN ACCOUNT BUTTON
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: !isChecked ? null : createAccount,
              child: const Text(AppTexts.createAnAccount),
            ),
          ),
        ],
      ),
    );
  }
}
