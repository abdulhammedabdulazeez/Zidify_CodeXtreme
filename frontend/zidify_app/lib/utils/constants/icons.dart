import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconly/iconly.dart';

class AppIcons {
  AppIcons._();

   //Home Screen Icons
  static const IconData bellIcon = Icons.notifications_none;
  static const IconData hiddenEyeIcon = Icons.visibility_off;
  static const IconData visibleEyeIcon = Icons.remove_red_eye_outlined;
  static const IconData goToIcon = IconlyLight.arrow_right_circle;
  static const IconData depositIcon = Icons.add_circle_outline_outlined;
  static const IconData backIcon = Icons.arrow_back;

  //Nav Bar Icons
  // static const IconData homeIcon = Icons.home_outlined;
  static const IconData homeIcon = IconlyLight.home;
  static const IconData homeIconFilled = IconlyBold.home;
  static const IconData savingsIcon = IconlyLight.wallet;
  static const IconData savingsIconFilled = IconlyBold.wallet;
  static const IconData historyIcon = IconlyLight.time_circle;
  static const IconData historyIconFilled = IconlyBold.time_circle;
  static const IconData profileIcon = IconlyLight.profile;
  static const IconData profileIconFilled = IconlyBold.profile;

  //SaveBox Screen Icons
  // static const IconData withdrawIcon = FontAwesomeIcons.moneyBillTransfer;
  static const IconData withdrawIcon = FontAwesomeIcons.landmark;
}