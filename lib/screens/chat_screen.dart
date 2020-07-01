import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salut/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseUser loggedInUser;

class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageController = TextEditingController();
  final _fireStoreObject = Firestore.instance;
  final _auth= FirebaseAuth.instance;

  String messageTyped;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  //print out current logged on user's email address.
  void getCurrentUser()async{

    try{
      final user = await  _auth.currentUser();
      if(user != null){
        loggedInUser = user;
      }
    }catch(e){
      print(e);
    }
  }


  void messageStream() async{
   await for( var snapshot in _fireStoreObject.collection('messages').snapshots()){
     for( var message in snapshot.documents){

     }
   };

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        elevation: 5,
        title: Center(child: Text('Message', style: TextStyle(fontStyle:FontStyle.italic),)),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream: _fireStoreObject.collection('messages').snapshots(),
              //provides the build stategy, the logic for what the stream builder should actually do.
              builder: (context, snapshot){
                if(snapshot.hasData){
                  //our object contains a query snapshot from firestore, which contains a list of ducuments
                  final messages = snapshot.data.documents.reversed;

                  List<Widget> messageBubbles =[];
                  for(var message in messages){
                    final messageText = message.data['text'];
                    final senderText = message.data['sender'];

                    final currentUser = loggedInUser.email;



                    final messageValue = MessageBubble(sender:senderText, text: messageText,isMe: currentUser == senderText,);

                    messageBubbles.add(messageValue);
                  }
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal:10.0, vertical: 20.0),
                      child: ListView(
                        reverse: true,
                        children: messageBubbles,

                      ),
                    ),
                  );

                }
               return null;
              },

            ),

            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:10.0, vertical: 0.0),
                    child: Icon(Icons.edit,color: Colors.lightBlueAccent,),
                  ),
                  Expanded(
                    child: TextField(

                      controller: messageController,
                      onChanged: (value) {
                        messageTyped = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      messageController.clear();
                      _fireStoreObject.collection('messages').add({
                      'text':messageTyped,
                        'sender': loggedInUser.email,

                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class MessageBubble extends StatelessWidget {
  MessageBubble({this.sender, this.text, this.isMe});

  final String sender;
 final  String text;
 final bool isMe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: isMe? CrossAxisAlignment.end: CrossAxisAlignment.start,
        children: <Widget>[

          Material(
              color: isMe?Colors.lightBlueAccent: Colors.white,
              borderRadius:isMe?  BorderRadius.only(
                 topLeft: Radius.circular(30.0),bottomLeft: Radius.circular(30.0), bottomRight: Radius.circular(30.0)):
              BorderRadius.only(
                  topRight: Radius.circular(30.0),bottomLeft: Radius.circular(30.0), bottomRight: Radius.circular(30.0)
              ),
              elevation: 10.0,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('$text ',style: isMe?TextStyle( color: Colors.white, fontSize: 15.0): TextStyle( color: Colors.lightBlue, fontSize: 15.0),),
              )),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(sender, style:TextStyle(color: Colors.blueGrey,fontSize: 12,fontStyle: FontStyle.italic)),
          ),
        ],
      ),
    );
  }
}

