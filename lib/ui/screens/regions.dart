import 'package:contact_tracing/services/constants/variables.dart';
import 'package:contact_tracing/services/metrics/deviceMetrics.dart';
import 'package:contact_tracing/services/utils/navigation.dart';
import 'package:contact_tracing/services/utils/shared.dart';
import 'package:contact_tracing/ui/widgets/bottom.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'homeScreen.dart';

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
                                                          icon: Icon(Icons.clear),
                                                          onPressed: () =>
                                                              UserNavigation.pop(
                                                                  context))
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Text(
                                                    'How to check that gjhfgabhkf',
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
                                                    '''Taarifa ya robo ya pili ya mapato ya Halmashauri, iliyotolewa na Waziri wa Nchi Ofisi ya Rais-TAMISEMI
January 21, 2021
Orodha ya majina ya matokeo ya kidato cha nne,cha pili na darasa la nne
January 18, 2021''',
                                                    textAlign: TextAlign.start,
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    '''Taarifa ya robo ya pili ya mapato ya Halmashauri, iliyotolewa na Waziri wa Nchi Ofisi ya Rais-TAMISEMI
January 21, 2021
Orodha ya majina ya matokeo ya kidato cha nne,cha pili na darasa la nne
January 18, 2021''',
                                                    textAlign: TextAlign.start,
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    '''Taarifa ya robo ya pili ya mapato ya Halmashauri, iliyotolewa na Waziri wa Nchi Ofisi ya Rais-TAMISEMI
January 21, 2021
Orodha ya majina ya matokeo ya kidato cha nne,cha pili na darasa la nne
January 18, 2021''',
                                                    textAlign: TextAlign.start,
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    '''Taarifa ya robo ya pili ya mapato ya Halmashauri, iliyotolewa na Waziri wa Nchi Ofisi ya Rais-TAMISEMI
January 21, 2021
Orodha ya majina ya matokeo ya kidato cha nne,cha pili na darasa la nne
January 18, 2021''',
                                                    textAlign: TextAlign.start,
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    '''Taarifa ya robo ya pili ya mapato ya Halmashauri, iliyotolewa na Waziri wa Nchi Ofisi ya Rais-TAMISEMI
January 21, 2021
Orodha ya majina ya matokeo ya kidato cha nne,cha pili na darasa la nne
January 18, 2021''',
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
