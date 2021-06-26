import 'dart:async';

import 'package:contact_tracing/screens/animation/loaders.dart';
import 'package:contact_tracing/screens/onBoarding%20Screen.dart';
import 'package:contact_tracing/services/constants/variables.dart';
import 'package:contact_tracing/services/metrics/deviceMetrics.dart';
import 'package:contact_tracing/services/utils/navigation.dart';
import 'package:contact_tracing/services/utils/shared.dart';
import 'package:flutter/material.dart';

import 'homsScreen.dart';
import 'regions.dart';

class Loader extends StatefulWidget {
  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  @override
  void initState() {
    TempMemory.getBool(key: 'splash').then((value) async {
      setState(() {
        firstTime = value;
      });
    });
    TempMemory.getBool(key: 'regions').then((value) async {
      setState(() {
        regionsNotSelected = value;
      });
    });
    Timer(Duration(seconds: 3), () async {
      if (firstTime) {
        UserNavigation.pushReplace(context, destination: Splash());
      } else {
        if (regionsNotSelected) {
          UserNavigation.pushReplace(context, destination: Regions());
        } else {
          UserNavigation.pushReplace(context, destination: HomeScreen());
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.tealAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ThreeBounceLoader(),
            SizedBox(
              height: DeviceMetrics.deviceHeight(context) / 10,
            ),
            Text(
              'Loading Contents, Please wait ....',
              style:
                  TextStyle(fontSize: DeviceMetrics.deviceWidth(context) / 25),
            )
          ],
        ),
      ),
    );
  }
}
