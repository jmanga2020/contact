import 'package:contact_tracing/metrics/deviceMetrics.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informations'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 25.0),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Card(
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: Metrics.deviceWidth(context) / 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'What you can do to protect yourself',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'Find Out More',
                              style: TextStyle(color: Colors.blue[400]),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => null,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Image.asset('assets/images/manymask.jpg',
                        width: Metrics.deviceWidth(context) / 3)
                    // Image.network(_image, width: Metrics.deviceWidth(context) / 3)
                  ],
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(Metrics.deviceWidth(context) / 30))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Card(
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: Metrics.deviceWidth(context) / 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'What can you do to protect others',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'Find Out More',
                              style: TextStyle(color: Colors.blue[400]),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => null,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Image.asset('assets/images/meter.jpg',
                        width: Metrics.deviceWidth(context) / 3)
                    // Image.network(_image, width: Metrics.deviceWidth(context) / 3)
                  ],
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(Metrics.deviceWidth(context) / 30))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Card(
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: Metrics.deviceWidth(context) / 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'How the application works',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'Learn more',
                              style: TextStyle(color: Colors.blue[400]),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => null,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Image.asset('assets/images/kazi1.png',
                        width: Metrics.deviceWidth(context) / 3)
                    // Image.network(_image, width: Metrics.deviceWidth(context) / 3)
                  ],
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(Metrics.deviceWidth(context) / 30))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: Metrics.deviceWidth(context) / 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Lab tech panel',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'Login',
                              style: TextStyle(color: Colors.blue[400]),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => {
                                      Navigator.pushNamed(
                                          context, '/loginScreen')
                                    },
                            ),
                          )
                        ],
                      ),
                    ),
                    Image.asset('assets/images/doct.png',
                        width: Metrics.deviceWidth(context) / 3)
                    //Image.network(_image, width: Metrics.deviceWidth(context) / 3)
                  ],
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(Metrics.deviceWidth(context) / 20))),
            ),
          ),
        ],
      ),
    );
  }
}
