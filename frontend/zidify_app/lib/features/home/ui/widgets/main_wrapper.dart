import 'package:zidify_app/utils/constants/icons.dart';
import 'package:zidify_app/utils/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zidify_app/utils/constants/sizes.dart';
import 'package:zidify_app/utils/constants/colors.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  void _goBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      // height: AppSizes.bottomNavHeight,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(AppIcons.homeIcon),
            label: AppTexts.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(AppIcons.savingsIcon),
            label: AppTexts.savings,
          ),
          BottomNavigationBarItem(
            icon: Icon(AppIcons.historyIcon),
            label: AppTexts.history,
          ),
          BottomNavigationBarItem(
            icon: Icon(AppIcons.profileIcon),
            label: AppTexts.profile,
          ),
        ],
        currentIndex: widget.navigationShell.currentIndex,
        onTap: (index) {
          _goBranch(index);
        },
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.darkGrey,
        backgroundColor: AppColors.white,
        type: BottomNavigationBarType.fixed,
        iconSize: AppSizes.iconLg,
        unselectedFontSize: AppSizes.fontSizeSm,
        selectedFontSize: AppSizes.fontSizeSm,
      ),
    );
  }
}
