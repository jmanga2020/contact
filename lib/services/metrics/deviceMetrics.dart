import 'package:flutter/material.dart';

class DeviceMetrics {
  ///get device Height
  static double deviceHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  ///get device Width
  static double deviceWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
}
