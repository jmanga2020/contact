import 'package:contact_tracing/models/homeData.dart';
import 'package:contact_tracing/services/metrics/deviceMetrics.dart';
import 'package:contact_tracing/services/utils/navigation.dart';
import 'package:contact_tracing/ui/widgets/bottom.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flat_icons_flutter/flat_icons_flutter.dart';

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
                      leading: Icon(FontAwesomeIcons.headSideMask),
                      title: Text('WEAR A MASK, MAKE WEARING A MASK A NORMAL PART OF BEING AROUND OTHER PEOPLE'),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(FontAwesomeIcons.handsWash),
                      title: Text('REGULARLY AND THOROUGHLY CLEAN YOUR HANDS WITH AN ALCOHOL BASED HAND RUB OR WASH THEM WITH SOAP AND WATER'),
                    ),
                    Divider(),
                     ListTile(
                      leading: Icon(Icons.face_outlined,),
                      title: Text('AVOID TOUCHING YOUR EYES,NOSE AND MOUTH'),
                    ),
                     Divider(),
                     ListTile(
                      leading: Icon(FontAwesomeIcons.headSideCoughSlash),
                      title: Text('COVER YOUR MOUTH AND NOSE WITH YOUR BENT ELBOW OR TISSUE WHEN YOU COUGH OR SNEEZE'),
                    ),
                     Divider(),
                     ListTile(
                      leading: Icon(Icons.sanitizer_outlined,),
                      title: Text('CLEAN AND DISINFECT SURFACES FREQUENTLY ESPECIALLY THOSE WHICH ARE REGULARLY TOUCHED,SUCH AS DOOR HANDLES,FAUCETS,SHOPPING CARTS,ELEVATOR BUTTONS, PHONE SCREENS'),
                    ),
                     Divider(),
                     ListTile(
                      leading: Icon(FontAwesomeIcons.syringe),
                      title: Text('GET VACCINATED'),
                    ),


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
                    leading: Icon(FontAwesomeIcons.peopleArrows),
                    title: Text('MAINTAIN AT LEAST ONE METRE DISTANCE BETWEEN YOURSELF AND OTHERS'),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.reduce_capacity_outlined,),
                    title: Text('AVOID CROWDS AND POORLY VENTILATED SPACES'),
                  ),
                  Divider(),
                   ListTile(
                    leading: Icon(FlatIcons.home),
                    title: Text('STAY HOME AND SELF ISOLATE EVEN IF YOU HAVE MINOR SYMPTOMS SUCH AS COUGH,HEADACHE AND MILD FEVER'),
                  ),
                    Divider(),
                  ListTile(
                    leading: Icon(FontAwesomeIcons.hospital),
                    title: Text('IF YOU HAVE A FEVER,COUGH AND DIFFICULTY BREATHING SEEK MEDICAL ATTENTION IMMEDIATELY'),
                  ),

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
                    leading: Icon(Icons.notifications),
                    title: Text('THE APP GIVES YOU NOTIFICATION ABOUT PEOPLE YOU CAME IN CONTACT WITH AND THEY ARE COVID 19 POSITIVE,WHICH MEANS THEY ARE INFECTED,THE APP ALSO GIVES YOU ALL THE POSSIBLE MEASURES TO FOLLOW INORDER TO PROTECT YOUR SELF AND THE ONES YOU LOVE'),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('THE APP WORKS WHERE BY WHEN YOU INTERACT WITH PEOPLE OR COME INTO CONTACT THERE IS KEY EXCHANGE MECHANISM WHERE BY EACH PERSON WILL HAVE A UNIQUE IDENTITY OF THE SOMEONE HE OR SHE CAME INTO CONTACT WITH AND WAIT FOR THE NOTIFICATION IF HE OR SHE IS INFECTED WITH COVID 19 AND HENCE TO FOLLOW THE MEASURES INSTRUCTED AND BE SAFE.'),
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