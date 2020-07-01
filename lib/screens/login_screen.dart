import 'package:flutter/material.dart';
import 'package:salut/components/RoundedButton.dart';
import 'package:salut/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:salut/screens/chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  String password;
  bool spinner = false;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: spinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                Icon(Icons.mail_outline,color: Colors.lightBlueAccent,),
                SizedBox(height: 30.0,width: 10,),
                Text('Email Address',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
              ],),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  //Do something with the user input.
                  email= value;
                },
                decoration: kTextFieldDecoration.copyWith(hintText: 'Enter a valid Email Address'),),
              SizedBox(
                height: 8.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.lock_outline,color: Colors.lightBlueAccent,),
                  SizedBox(height: 30.0,width: 10,),
                  Text('Password',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
                ],),

              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  //Do something with the user input.
                   password = value ;
                },
                decoration: kTextFieldDecoration.copyWith(hintText: 'Password should be at least 6 characters'),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(label: 'Login',colour: Colors.lightBlueAccent,whenPressed: ()async{
                setState(() {
                  spinner= true;
                });
               try{
                 final newUser= await _auth.signInWithEmailAndPassword(email: email, password: password);
                 if(newUser != null){
                   Navigator.pushNamed(context,ChatScreen.id );
                 }else{
                   print('wrong email or password!');
                 }
                 setState(() {
                   spinner = false;
                 });
               }catch(e){
                 print(e);
               }
              },)
            ],
          ),
        ),
      ),
    );
  }
}
