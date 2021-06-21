import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:contact_tracing/widget/button_widget.dart';
import 'package:contact_tracing/screens/homsScreen.dart';
import 'package:after_layout/after_layout.dart';

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

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SafeArea(
        child: IntroductionScreen(
          pages: [
            PageViewModel(
              title: 'Hallow! Welcome.',
              body:
                  'with everyone contribution,contact tracing app will help us contain the virus and get us back to normal life as soon as possible.  ',
              image: buildImage('assets/happy people.jpg'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Your privacy is protected',
              body:
                  'The app works without tracking your movements and without  knowing your identity or the identity of the people you come into contact with.',
              image: buildImage('assets/privacy1.1.jpg'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'contact tracing app takes care of you.',
              body:
                  'if you have been in contact with a user who has subsequently tested positive for the virus,the contact tracing app notifies you and gives you instructions to protect your health and your beloved ones.',
              image: buildImage('assets/notification.jpg'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'choose your region',
              body: 'regions',
              footer: ButtonWidget(
                text: 'Start Reading',
                onClicked: () => goToHome(context),
              ),
              // image: buildImage('assets/learn.png'),
              decoration: getPageDecoration(),
            ),
          ],
          done: Text('Read', style: TextStyle(fontWeight: FontWeight.w600)),
          onDone: () => goToHome(context),
          showSkipButton: true,
          skip: Text('Skip'),
          onSkip: () => goToHome(context),
          next: Icon(Icons.arrow_forward),
          dotsDecorator: getDotDecoration(),
          onChange: (index) => print('Page $index selected'),
          globalBackgroundColor: Theme.of(context).primaryColor,
          skipFlex: 0,
          nextFlex: 0,
          // isProgressTap: false,
          // isProgress: false,
          // showNextButton: false,
          // freeze: true,
          // animationDuration: 1000,
        ),
      );

  void goToHome(context) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => HomeScreen()),
      );

  Widget buildImage(String path) =>
      Center(child: Image.asset(path, width: 350));

  DotsDecorator getDotDecoration() => DotsDecorator(
        color: Color(0xFFBDBDBD),
        //activeColor: Colors.orange,
        size: Size(10, 10),
        activeSize: Size(20, 15),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      );

  PageDecoration getPageDecoration() => PageDecoration(
        titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        bodyTextStyle: TextStyle(fontSize: 20),
        descriptionPadding: EdgeInsets.all(16).copyWith(bottom: 0),
        imagePadding: EdgeInsets.all(24),
        pageColor: Colors.white,
      );
}
