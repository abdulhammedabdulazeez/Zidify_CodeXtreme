import 'package:zidify_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class TransactionSuccessful extends StatelessWidget {
  final String box;
  final VoidCallback onContinue;

  const TransactionSuccessful(
      {super.key, required this.box, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.green[50],
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.green,
              width: 2,
            ),
          ),
          padding: const EdgeInsets.all(80.0),
          child: const Center(
            child: Icon(
              Icons.check,
              size: 150,
              color: Colors.green,
            ),
          ),
        ),
        const Spacer(),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onContinue,
            child: Text(
              "Go To $box",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.white),
            ),
          ),
        ),
      ],
    );
  }
}
