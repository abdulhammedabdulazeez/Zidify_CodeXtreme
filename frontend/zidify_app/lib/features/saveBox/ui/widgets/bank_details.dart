import 'package:zidify_app/features/saveBox/domain_layer/entities/savebox_entity.dart';
import 'package:zidify_app/utils/constants/colors.dart';
import 'package:zidify_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BankDetails extends StatefulWidget {
  final SaveboxEntity saveBox;

  const BankDetails({super.key, required this.saveBox});

  @override
  _BankDetailsState createState() => _BankDetailsState();
}

class _BankDetailsState extends State<BankDetails> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        margin: const EdgeInsets.only(top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('or copy bank details'),
            const SizedBox(height: AppSizes.spaceBtwSections),
            GestureDetector(
              onTap: () async {
                // Copy account number to clipboard
                await Clipboard.setData(
                  ClipboardData(text: widget.saveBox.accountNumber),
                );
                // Show "Copied!" message
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Copied!'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.saveBox.accountNumber,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: AppColors.black),
                  ),
                  // const SizedBox(height: AppSizes.spaceBtwItemsSmall),
                  Text(
                    widget.saveBox.accountName,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: AppColors.black),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
