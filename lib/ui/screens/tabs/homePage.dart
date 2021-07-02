import 'package:contact_tracing/models/homeData.dart';
import 'package:contact_tracing/services/metrics/deviceMetrics.dart';
import 'package:contact_tracing/services/utils/navigation.dart';
import 'package:contact_tracing/ui/widgets/bottom.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../auth/logiScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> _previews = [];
  void _actions(int index) {
    switch (index) {
      case 0:
        bottomSheet(
            context,
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.account_balance),
                      title: Text('Hahjvkjb.vj'),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.account_balance),
                      title: Text('Hahjvkjb.vj'),
                    ),
                    Divider()
                  ],
                ),
              ),
            ));
        break;
      case 1:
        bottomSheet(
          context,
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.account_balance),
                    title: Text('Hahjvkjb.vj'),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.account_balance),
                    title: Text('Hahjvkjb.vj'),
                  ),
                  Divider()
                ],
              ),
            ),
          ),
        );
        break;
      case 2:
        bottomSheet(
          context,
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.account_balance),
                    title: Text('Hahjvkjb.vj'),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.account_balance),
                    title: Text('Hahjvkjb.vj'),
                  ),
                  Divider()
                ],
              ),
            ),
          ),
        );
        break;
      case 3:
        UserNavigation.push(context, destination: LoginScreen());
        break;
      default:
    }
  }

  @override
  void initState() {
    _previews = [
      HomeData(
              title: 'What you can do to protect yourself',
              image: 'assets/images/manymask.jpg')
          .toMap(),
      HomeData(
              title: 'What can you do to protect others',
              image: 'assets/images/meter.jpg')
          .toMap(),
      HomeData(
              title: 'How the application works',
              image: 'assets/images/kazi1.png')
          .toMap(),
      HomeData(
        title: 'Lab tech panel',
        image: 'assets/images/doct.png',
      ).toMap(),
    ];
    super.initState();
  }

  Widget _homeCards({int index, String title, String image}) {
    return GestureDetector(
      onTap: () => _actions(index),
      child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: Card(
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(
                  width: DeviceMetrics.deviceWidth(context) / 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$title',
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
                          text: index == 3 ? 'Login' : 'Find Out More',
                          style: TextStyle(color: Colors.blue[400]),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => _actions(index),
                        ),
                      ),
                    ],
                  ),
                ),
                Image.asset('$image',
                    width: DeviceMetrics.deviceWidth(context) / 3)
                // Image.network(_image, width: DeviceMetrics.deviceWidth(context) / 3)
              ],
            ),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(DeviceMetrics.deviceWidth(context) / 30))),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Information'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _previews.length,
        padding: EdgeInsets.only(top: 25.0),
        itemBuilder: (_, i) => _homeCards(
            index: i,
            title: _previews[i]['title'],
            image: _previews[i]['image']),
      ),
    );
  }
}
