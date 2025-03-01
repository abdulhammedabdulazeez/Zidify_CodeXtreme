import 'package:flutter/material.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/icons.dart';
import '../../../../utils/constants/texts.dart';
import '../../../../utils/constants/sizes.dart';

class TodoListWidget extends StatelessWidget {
  final List<Map<String, dynamic>> todolist = [
    {
      'taskdetail': AppTexts.tellUsAboutYourself,
      // 'color': AppColors.todoContainer,
      // 'buttonIcon': Icons.arrow_drop_down_circle_outlined,
    },
    {
      'taskdetail': AppTexts.linkMoMoAndATMCard,
      // 'color': AppColors.todoContainer,
      // 'buttonIcon': Icons.arrow_drop_down_circle_outlined,
    },
    {
      'taskdetail': AppTexts.setTransactionPin,
      // 'color': AppColors.todoContainer,
      // 'buttonIcon': Icons.arrow_drop_down_circle_outlined,
    },
    {
      'taskdetail': AppTexts.addWithdrawalBank,
      // 'color': AppColors.todoContainer,
      // 'buttonIcon': Icons.arrow_drop_down_circle_outlined,
    },
    {
      'taskdetail': AppTexts.verifyyourIdentity,
      // 'color': AppColors.todoContainer,
      // 'buttonIcon': Icons.arrow_drop_down_circle_outlined,
    },
    {
      'taskdetail': AppTexts.addApicture,
      // 'color': AppColors.todoContainer,
      // 'buttonIcon': Icons.arrow_drop_down_circle_outlined,
    },
  ];

  TodoListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.todoCarouselHeight, // Set height for the horizontal list
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // Horizontal scrolling
        itemCount: todolist.length,
        itemBuilder: (context, index) {
          String title = todolist[index]['taskdetail'];
          // Color color = todolist[index]['color'];
          // IconData buttonIcon = todolist[index]['buttonIcon'];

          return Container(
            width: AppSizes.todoCarouselWidth, // Fixed width for each card
            margin: EdgeInsets.only(
                left: index == 0 ? 0 : 4), // Space between cards
            child: Card(
              color: AppColors.todoContainer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.borderRadiusSm),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.black,
                          ),
                    ),
                    const Spacer(), // Add fixed height for spacing
                    const Align(
                      alignment: Alignment.bottomLeft,
                      child: Icon(
                        AppIcons.goToIcon,
                        size: AppSizes.iconSm, //icon size
                        color: AppColors.iconPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
