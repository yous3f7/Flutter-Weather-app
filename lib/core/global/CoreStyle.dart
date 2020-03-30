import 'package:flutter/material.dart';

abstract class CoreStyle {
  static double setWidthPercentage(percentage, context) {
    if (percentage<=100|| percentage>0)
      return MediaQuery.of(context).size.width * (percentage/100);
    else
      return MediaQuery.of(context).size.width;
  }
  static double setHeightPercentage(percentage, context) {
    if (percentage<=100|| percentage>0)
      return MediaQuery.of(context).size.height * (percentage/100);
    else
      return MediaQuery.of(context).size.height;
  }

  static const Color primaryValue = Color(0xFF24292E);
    static const Color primaryTheme = Color(0xff117abc);
  static const Color actionBlue = Color(0xff267aff);
  static const Color primaryLightTheme = Color(0xff428dff);
  static       Tween gredientTheme = ColorTween(begin:primaryTheme ,end: primaryLightTheme);
  static const Color primaryLightValue = Color(0xFF42464b);
  static const Color primaryDarkValue = Color(0xFF121917);

  static const Color cardWhite = Color(0xFFFFFFFF);
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color miWhite = Color(0xffececec);
  static const Color white = Color(0xFFFFFFFF);
  static const Color subTextColor = Color(0xff959595);
  static const Color subLightTextColor = Color(0xffc4c4c4);
  static const Color backGroundColor = Color(0xffE5E5E5);

  static const Color mainBackgroundColor = miWhite;

  static const Color mainTextColor = primaryDarkValue;
  static const Color textColorWhite = white;
}

abstract class GlobalTextStyle{
  static const biggestTextSize70dp = 70.0;
  static const lagerTextSize28dp = 28.0;
  static const bigTextSize18dp = 18.0;
  static const normalTextSize16dp = 16.0;
  static const middleTextWhiteSize14dp = 14.0;
  static const smallTextSize14dp = 14.0;
  static const minTextSize12dp = 12.0;

  static const minText = TextStyle(
    color: CoreStyle.subLightTextColor,
    fontSize: minTextSize12dp,
  );

  static const smallTextWhite = TextStyle(
    color: CoreStyle.textColorWhite,
    fontSize: smallTextSize14dp,
  );

  static const smallText = TextStyle(
    color: CoreStyle.mainTextColor,
    fontSize: smallTextSize14dp,
  );

  static const smallTextBold = TextStyle(
    color: CoreStyle.mainTextColor,
    fontSize: smallTextSize14dp,
    fontWeight: FontWeight.bold,
  );

  static const smallSubLightText = TextStyle(
    color: CoreStyle.subLightTextColor,
    fontSize: smallTextSize14dp,
  );

  static const smallActionLightText = TextStyle(
    color: CoreStyle.actionBlue,
    fontSize: smallTextSize14dp,
  );

  static const smallMiLightText = TextStyle(
    color: CoreStyle.miWhite,
    fontSize: smallTextSize14dp,
  );

  static const smallSubText = TextStyle(
    color: CoreStyle.subTextColor,
    fontSize: smallTextSize14dp,
  );

  static const middleText = TextStyle(
    color: CoreStyle.mainTextColor,
    fontSize: middleTextWhiteSize14dp,
  );

  static const middleTextWhite = TextStyle(
    color: CoreStyle.textColorWhite,
    fontSize: middleTextWhiteSize14dp,
  );

  static const middleSubText = TextStyle(
    color: CoreStyle.subTextColor,
    fontSize: middleTextWhiteSize14dp,
  );

  static const middleSubLightText = TextStyle(
    color: CoreStyle.subLightTextColor,
    fontSize: middleTextWhiteSize14dp,
  );

  static const middleTextBold = TextStyle(
    color: CoreStyle.mainTextColor,
    fontSize: middleTextWhiteSize14dp,
    fontWeight: FontWeight.bold,
  );

  static const middleTextWhiteBold = TextStyle(
    color: CoreStyle.textColorWhite,
    fontSize: middleTextWhiteSize14dp,
    fontWeight: FontWeight.bold,
  );

  static const middleSubTextBold = TextStyle(
    color: CoreStyle.subTextColor,
    fontSize: middleTextWhiteSize14dp,
    fontWeight: FontWeight.bold,
  );

  static const normalText = TextStyle(
    color: CoreStyle.mainTextColor,
    fontSize: normalTextSize16dp,
  );

  static const normalTextBold = TextStyle(
    color: CoreStyle.mainTextColor,
    fontSize:normalTextSize16dp,
    fontWeight: FontWeight.bold,
  );

  static const normalTextBoldForMessage = TextStyle(
      color: CoreStyle.mainTextColor,
      fontSize:normalTextSize16dp,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic
  );

  static const normalSubText = TextStyle(
    color: CoreStyle.subTextColor,
    fontSize: normalTextSize16dp,
  );

  static const normalTextWhite = TextStyle(
    color: CoreStyle.textColorWhite,
    fontSize: normalTextSize16dp,
  );

  static const normalTextMitWhiteBold = TextStyle(
    color: CoreStyle.miWhite,
    fontSize: normalTextSize16dp,
    fontWeight: FontWeight.bold,
  );

  static const normalTextActionWhiteBold = TextStyle(
    color: CoreStyle.actionBlue,
    fontSize: normalTextSize16dp,
    fontWeight: FontWeight.bold,
  );

  static const normalTextLight = TextStyle(
    color: CoreStyle.primaryLightValue,
    fontSize: normalTextSize16dp,
  );

  static const largeText = TextStyle(
    color: CoreStyle.mainTextColor,
    fontSize: bigTextSize18dp,
  );

  static const largeTextBold = TextStyle(
    color: CoreStyle.mainTextColor,
    fontSize: bigTextSize18dp,
    fontWeight: FontWeight.bold,
  );

  static const largeTextWhite = TextStyle(
    color: CoreStyle.textColorWhite,
    fontSize: bigTextSize18dp,
  );

  static const largeTextWhiteBold = TextStyle(
    color: CoreStyle.textColorWhite,
    fontSize: bigTextSize18dp,
    fontWeight: FontWeight.bold,
  );

  static const largeLargeTextWhiteBold = TextStyle(
    color: CoreStyle.textColorWhite,
    fontSize: lagerTextSize28dp,
    fontWeight: FontWeight.bold,
  );

  static const largeLargeTextWhite = TextStyle(
    color: CoreStyle.textColorWhite,
    fontSize: lagerTextSize28dp,
  );

  static const largeLargeText = TextStyle(
    color: CoreStyle.primaryValue,
    fontSize: lagerTextSize28dp,
    fontWeight: FontWeight.bold,
  );

  static const biggestTextWhite = TextStyle(
    color: CoreStyle.textColorWhite,
    fontSize: biggestTextSize70dp ,
  );
}
