import 'package:zidify_app/utils/constants/colors.dart';
import 'package:zidify_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class InputPasswordTile extends StatelessWidget {
  const InputPasswordTile({
    super.key,
    required this.headerText,
    required this.hintText,
    required this.isObscured,
    required this.toggleObscureText,
    required this.validator,
    required this.controller,
    required this.onSaved,
  });

  final String headerText;
  final String hintText;
  final bool isObscured;
  final VoidCallback toggleObscureText;
  final String? Function(String?) validator;
  final TextEditingController controller;
  final String? Function(String?) onSaved;

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
          obscureText: isObscured,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: AppColors.darkGrey),
            suffixIcon: IconButton(
              onPressed: toggleObscureText,
              icon: isObscured
                  ? const Icon(Iconsax.eye_slash)
                  : const Icon(Iconsax.eye),
            ),
            suffixIconColor: const Color(0xFF9CA3AF),
          ),
          validator: validator,
          controller: controller,
          onSaved: onSaved,
        ),
      ],
    );
  }
}
