import 'package:curt_task/core/utililes/app_colors.dart';
import 'package:flutter/material.dart';

class FontStyles {
  static late TextStyle? loginHeader;
  static late TextStyle? login;
  static late TextStyle? welcomHeader;
  static late TextStyle? welcomBody;
  static late TextStyle? welcomButton;
  static late TextStyle? addItem;
  static late TextStyle? secondSmallInfo;
  static late TextStyle? secondSmallInfoThin;
  static late TextStyle? smallButtonTextWhite;
  static late TextStyle? smallButtonTextBlack;
  static late TextStyle? price;
  static late TextStyle? registrationInputHint;
  static late TextStyle? registrationInputBody;

  static void init() {
    loginHeader = const TextStyle(
        fontSize: 25, fontWeight: FontWeight.w200, color: darkPurple);
    login = const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      color: wight,
    );

    welcomHeader = const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    );
    welcomBody = const TextStyle(
        fontSize: 15, fontWeight: FontWeight.w400, color: darkPurple);

    welcomButton = const TextStyle(fontSize: 20, fontWeight: FontWeight.w400);

    addItem = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w400,
    );
    secondSmallInfo = const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: Colors.purple,
    );
    secondSmallInfoThin = const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w200,
      color: Colors.purple,
    );
    smallButtonTextWhite = const TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w400,
    );
    smallButtonTextBlack = const TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    );
    price = const TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    );
    registrationInputHint = const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: Colors.purple,
    );
    registrationInputBody =
        const TextStyle(fontSize: 15, fontWeight: FontWeight.w400);
  }
}
