import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ThreeBounceLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SpinKitThreeBounce(
      color: Colors.white,
      size: 50.0,
    );
  }
}

class UniversalLoader extends StatelessWidget {
  final String label;
  const UniversalLoader({Key key, this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SpinKitFadingCircle(
              color: Colors.green,
              size: 50.0,
            ),
            SizedBox(
              height: 20,
            ),
            Text('${label ?? 'Loading, Please wait...'}')
          ],
        ),
      ),
    );
  }
}
