import 'dart:async';

import 'package:contact_tracing/services/constants/variables.dart';
import 'package:contact_tracing/services/metrics/deviceMetrics.dart';
import 'package:contact_tracing/services/utils/navigation.dart';
import 'package:contact_tracing/services/utils/shared.dart';
import 'package:contact_tracing/ui/screens/records/patient_records.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

import 'animation/loaders.dart';
import 'home.dart';
import 'tabs/homePage.dart';
import 'regions.dart';
import 'splashScreen.dart';

class Loader extends StatefulWidget {
  @override
  _LoaderState createState() => _LoaderState();
}

FlutterBlue blue;

class _LoaderState extends State<Loader> {
  @override
  void initState() {
    setState((){
      blue = FlutterBlue.instance;
    });
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
    TempMemory.getString(key: 'region').then((value) async {
      setState(() {
        chosenRegion = value;
      });
    });
    TempMemory.getString(key: 'admin').then((value) async {
      setState(() {
        admin = value;
      });
    });
    Timer(Duration(seconds: 3), () async {
      if (firstTime) {
        UserNavigation.pushReplace(context, destination: Splash());
      } else {
        if (regionsNotSelected) {
          UserNavigation.pushReplace(context, destination: Regions());
        } else {
          if (admin.isNotEmpty) {
            UserNavigation.pushReplace(context, destination: PatientRecords());
          } else {
            UserNavigation.pushReplace(context, destination: Home());
          }
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
