import 'package:flutter/material.dart';

class MediaQueryHelpers {
  static double screenWidth(BuildContext context, {double multiplier = 1}) {
    return MediaQuery.of(context).size.width * multiplier;
  }

  static double screenHeight(BuildContext context, {double multiplier = 1}) {
    return MediaQuery.of(context).size.height * multiplier;
  }

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 850;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
      MediaQuery.of(context).size.width >= 850;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;
}
