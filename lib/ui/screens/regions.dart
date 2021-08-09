import 'package:contact_tracing/services/constants/variables.dart';
import 'package:contact_tracing/services/metrics/deviceMetrics.dart';
import 'package:contact_tracing/services/utils/navigation.dart';
import 'package:contact_tracing/services/utils/shared.dart';
import 'package:contact_tracing/ui/screens/home.dart';
import 'package:contact_tracing/ui/widgets/bottom.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';


class Regions extends StatefulWidget {
  @override
  _RegionsState createState() => _RegionsState();
}
  String chosenRegion = '';
class _RegionsState extends State<Regions> {

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
                              RichText(
                                text: TextSpan(
                                  text: 'Find Out More',
                                  style: TextStyle(color: Colors.blue[400]),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => bottomSheet(
                                        context,
                                        SizedBox(
                                          width: DeviceMetrics.deviceWidth(
                                              context),
                                          height: DeviceMetrics.deviceHeight(
                                                  context) /
                                              2,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: DeviceMetrics
                                                            .deviceHeight(
                                                                context) /
                                                        40,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      IconButton(
                                                          icon:
                                                              Icon(Icons.clear),
                                                          onPressed: () =>
                                                              UserNavigation
                                                                  .pop(context))
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Text(
                                                    'Why we ask you to enter your home region?',
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: DeviceMetrics
                                                                .deviceWidth(
                                                                    context) /
                                                            25),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    '''Select the region where you live in to help our Tanzanian Nation''',
                                                    textAlign: TextAlign.start,
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    '''The National Health Service uses your home region details to help prevent new outbreaks,as well as to estimate how widely the app is being used across the country.''',
                                                    textAlign: TextAlign.start,
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    '''you can also change your home region at any time from the app's info,we advise you to change them only if you decide to move from one region to another''',
                                                    textAlign: TextAlign.start,
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    '''USE CONTACT TRACING APP TO SAVE LIVES!''',
                                                    textAlign: TextAlign.start,
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    '''THANK YOU!!!''',
                                                    textAlign: TextAlign.start,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        )),
                                ),
                              ),
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
                                    groupValue: chosenRegion,
                                    onChanged: (value) {
                                      setState(() {
                                        if (value != null) {
                                          chosenRegion = value;
                                        }
                                      });
                                    })))
                      ]),
                    )
                  ],
                ),
              ),
              chosenRegion.isEmpty
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
                                      key: 'region', value: chosenRegion);
                                  UserNavigation.pushReplace(context,
                                      destination: Home());
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
