import 'package:flutter/material.dart';
import 'package:salut/screens/welcome_screen.dart';
import 'package:salut/screens/login_screen.dart';
import 'package:salut/screens/registration_screen.dart';
import 'package:salut/screens/chat_screen.dart';

void main() => runApp(Salut());

class Salut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: WelcomeScreen.id,
      routes:{
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id:(context) => RegistrationScreen(),
        WelcomeScreen.id:(context) => WelcomeScreen(),
        ChatScreen.id:(context) => ChatScreen(),

      },
      //home: WelcomeScreen(),
    );
  }
}
