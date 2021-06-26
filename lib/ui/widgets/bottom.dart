import 'package:contact_tracing/services/metrics/deviceMetrics.dart';
import 'package:flutter/material.dart';

void bottomSheet(BuildContext context, Widget widget) {
  showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(DeviceMetrics.deviceWidth(context)/10), topRight: Radius.circular(DeviceMetrics.deviceWidth(context)/10))),
      context: context,
      builder: (_) => widget);
}
