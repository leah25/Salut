import 'package:flutter/material.dart';
import 'package:salut/screens/login_screen.dart';
import 'package:salut/screens/registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:salut/components/RoundedButton.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  AnimationController controller;
//  Animation animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 1),
        vsync: this,
      upperBound: 100.0,

    );

    controller.forward();
    // this checks to see how the value changes.
//    controller.addListener(() {
//      print(controller.value);
//    });
    
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(

                  tag:'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60,
                  ),
                ),
//                SizedBox(width: 15.0,),
                ColorizeAnimatedTextKit(
                  text:['Bonjour..',
                  'Hello..',' Hola..' ,
          'Nǐn hǎo..' ,'Salve..','Konnichiwa','Guten Tag..','Olá..'],
                  colors: [
                    Colors.red,
                    Colors.blue,
                    Colors.yellow,
                    Colors.purpleAccent,
                  ],
                  textStyle: TextStyle(
                    fontSize: 60.0,
                    fontWeight: FontWeight.w900,
                    color: Colors.red,
                      fontStyle: FontStyle.italic
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(label: 'login', colour: Colors.lightBlueAccent,whenPressed: () {
              //Go to login screen.
              Navigator.pushNamed(context, LoginScreen.id);
            },),
            RoundedButton(label: 'register', colour: Colors.blueAccent,whenPressed: () {
              //Go to login screen.
              Navigator.pushNamed(context, RegistrationScreen.id);
            },),
          ],
        ),
      ),
    );
  }
}


