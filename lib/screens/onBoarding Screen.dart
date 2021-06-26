import 'package:contact_tracing/screens/regions.dart';
import 'package:contact_tracing/services/utils/navigation.dart';
import 'package:contact_tracing/services/utils/shared.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/dot_animation_enum.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:contact_tracing/screens/homsScreen.dart';

// class Splash extends StatefulWidget {
//   // const Splash({ Key? key }) : super(key: key);

//   @override
//   SplashState createState() => SplashState();
// }

// class SplashState extends State<Splash> with AfterLayoutMixin<Splash> {
//    Future checkFirstSeen() async {
//     // SharedPreferences prefs = await SharedPreferences.getInstance();
//     // bool _seen = (prefs.getBool('seen') ?? false);

//     // if (_seen) {
//     //   Navigator.of(context).pushReplacement(
//     //       new MaterialPageRoute(builder: (context) => new HomeScreen()));
//     // } else {
//     //   await prefs.setBool('seen', true);
//     //   Navigator.of(context).pushReplacement(
//     //       new MaterialPageRoute(builder: (context) => new Splash()));
//     // }
//     Navigator.of(context).pushReplacement(
//           new MaterialPageRoute(builder: (context) => new Splash()));
//   }

//   @override
//    void afterFirstLayout(BuildContext context) => checkFirstSeen();

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  List<Slide> _slides = [];

  @override
  void initState() {
    _slides = [
      Slide(
        title: "Hallow! Welcome.",
        description:
            '''with everyone contribution,contact tracing app will help us contain the virus and get us back to normal life as soon as possible.  ''',
        pathImage: "assets/images/kazi.jpg",
        backgroundColor: Color(0xfff5a623),
      ),
      Slide(
        title: "Your privacy is protected",
        description:
            '''The app works without tracking your movements and without  knowing your identity or the identity of the people you come into contact with..  ''',
        pathImage: "assets/images/kazi.jpg",
        backgroundColor: Color(0xfff5a623),
      ),
      Slide(
        title: "contact tracing app takes care of you.",
        description:
            '''if you have been in contact with a user who has subsequently tested positive for the virus,the contact tracing app notifies you and gives you instructions to protect your health and your beloved ones.  ''',
        pathImage: "assets/images/kazi.jpg",
        backgroundColor: Color(0xfff5a623),
      ),
      Slide(
        title: "contact tracing app takes care of you.",
        description:
            '''if you have been in contact with a user who has subsequently tested positive for the virus,the contact tracing app notifies you and gives you instructions to protect your health and your beloved ones.  ''',
        pathImage: "assets/images/kazi.jpg",
        backgroundColor: Color(0xfff5a623),
      )
    ];
    super.initState();
  }

  void _done() {
    TempMemory.writeBool(key: 'splash', value: false).whenComplete(() async {
      UserNavigation.pushReplace(context, destination: Regions());
    });
  }

  @override
  Widget build(BuildContext context) => SafeArea(
          child: IntroSlider(
        slides: _slides,
        showDoneBtn: true,
        typeDotAnimation: dotSliderAnimation.SIZE_TRANSITION,
        showNextBtn: true,
        showDotIndicator: true,
        showPrevBtn: true,
        colorDot: Colors.black,
        onDonePress: _done,
      ));
}
