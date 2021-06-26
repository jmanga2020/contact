import 'package:contact_tracing/screens/homsScreen.dart';
import 'package:contact_tracing/services/constants/variables.dart';
import 'package:contact_tracing/services/metrics/deviceMetrics.dart';
import 'package:contact_tracing/services/utils/navigation.dart';
import 'package:contact_tracing/services/utils/shared.dart';
import 'package:flutter/material.dart';

class Regions extends StatefulWidget {
  @override
  _RegionsState createState() => _RegionsState();
}

class _RegionsState extends State<Regions> {
  String _chosenRegion = '';
  Widget _regions({String value, String title, onChanged, groupValue}) {
    return RadioListTile(
        title: Text('$title'),
        value: value,
        groupValue: groupValue,
        onChanged: onChanged);
  }

  Future<bool> _pop() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: _pop,
        child: Scaffold(
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                        expandedHeight: 100,
                        backgroundColor: Colors.white,
                        pinned: true,
                        centerTitle: true,
                        automaticallyImplyLeading: false,
                        elevation: 5,
                        flexibleSpace: FlexibleSpaceBar(
                          centerTitle: true,
                          title: Text('Which region do you live in?',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.green,
                              )),
                        )),
                    SliverList(
                      delegate: SliverChildListDelegate([
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  '''Select the region where you live to help the national health service provide the best possible assistance.'''),
                              SizedBox(
                                height: 20,
                              ),
                              Text('Find out more',
                                  style: TextStyle(color: Colors.blue))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                            children: List.generate(
                                tanzanianRegions.length,
                                (index) => _regions(
                                    title: '${tanzanianRegions[index]['city']}',
                                    value: '${tanzanianRegions[index]['city']}',
                                    groupValue: _chosenRegion,
                                    onChanged: (value) {
                                      setState(() {
                                        if (value != null) {
                                          _chosenRegion = value;
                                        }
                                      });
                                    })))
                      ]),
                    )
                  ],
                ),
              ),
              _chosenRegion.isEmpty
                  ? SizedBox()
                  : Positioned(
                      bottom: 0,
                      child: Container(
                          height: DeviceMetrics.deviceHeight(context) / 20,
                          color: Colors.green,
                          width: DeviceMetrics.deviceWidth(context),
                          child: Center(
                            child: InkWell(
                              splashColor: Colors.white12,
                              onTap: () {
                                TempMemory.writeBool(
                                        key: 'regions', value: false)
                                    .whenComplete(() async {
                                  setState(() {
                                    regionsNotSelected = false;
                                  });
                                  TempMemory.writeString(
                                      key: 'region', value: _chosenRegion);
                                  UserNavigation.pushReplace(context,
                                      destination: HomeScreen());
                                });
                              },
                              child: SizedBox(
                                  height:
                                      DeviceMetrics.deviceHeight(context) / 20,
                                  width: DeviceMetrics.deviceWidth(context),
                                  child: Center(child: Text('Next'))),
                            ),
                          )))
            ],
          ),
        ),
      ),
    );
  }
}
