import 'package:zidify_app/utils/constants/colors.dart';
import 'package:zidify_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class SignUpInputTile extends StatelessWidget {
  const SignUpInputTile({
    super.key,
    required this.headerText,
    required this.hintText,
    required this.validator,
    required this.controller,
    required this.onSaved,
  });

  final String headerText;
  final String hintText;
  final String? Function(String?) validator;
  final String? Function(String?) onSaved;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: AppSizes.sm),
          child: Text(
            headerText,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        TextFormField(
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: AppColors.darkGrey),
          ),
          validator: validator,
          controller: controller,
          onSaved: onSaved,
        ),
      ],
    );
  }
}
