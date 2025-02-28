import 'package:flutter/material.dart';

import '../constants/colors.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Flexible(
          child: Divider(
            color: AppColors.grey,
            thickness: 0.5,
            indent: 5,
            endIndent: 20,
          ),
        ),
        Text(text,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: AppColors.darkGrey)),
        const Flexible(
          child: Divider(
            color: AppColors.grey,
            thickness: 0.5,
            indent: 20,
            endIndent: 5,
          ),
        )
      ],
    );
  }
}
