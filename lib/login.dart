import 'package:chat/chat.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'constant.dart';
import 'button.dart';

class LoginScreen extends StatefulWidget {

  static const String id = 'login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final  _auth = FirebaseAuth.instance;
  String email;
  String password ;

  Future<void> loginUser()async{
    final User myUser = (await _auth.signInWithEmailAndPassword(email: email, password: password)).user;
    if(myUser!= null){
      Navigator.push(context,MaterialPageRoute(builder: (context){
      return ChatScreen(users:myUser);
    }));
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 180.0),
            children: [
            Row(
              children: [
                Hero(
                  tag: 'logo',
                  child: CircleAvatar(
                    backgroundImage: AssetImage('images/chat.jpg'),
                    radius: 30.0,
                  )
                ),
                Text('Chat App ',style:textStyle),
              ],
            ),
              SizedBox(
                height: 20.0,
              ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              decoration:textFieldDecoration.copyWith(hintText: 'Enter your Email' ),
              onChanged: (value){email=value;}
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              obscureText: true,
              decoration: textFieldDecoration.copyWith(hintText: 'Enter your password' ),
              onChanged: (value){password=value;},
            ),
              SizedBox(
                height: 20.0,
              ),
              CustomButton(
                title: 'Login',onPress: ()async{
               await loginUser();
                },),
          ],),
        ),
      ),
    );
  }
}
