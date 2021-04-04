import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat.dart';
import 'constant.dart';
import 'button.dart';
class RegisterScreen extends StatefulWidget {

  static const String id = 'register';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final  _auth = FirebaseAuth.instance;
  String email;
  String password ;

  Future<void> registerUser()async{
    final User newUser = (await _auth.createUserWithEmailAndPassword(email: email, password: password)).user;
    if(newUser!= null)
      {
        Navigator.push(context, MaterialPageRoute(builder: (context){return ChatScreen(users: newUser,);}));
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 60.0),
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
                Text('Chat App ',style:textStyle,),
              ],
            ),
              SizedBox(
                height: 20.0,
              ),
            TextField(decoration: textFieldDecoration.copyWith(hintText: 'First Name'),keyboardType:TextInputType.name),
              SizedBox(
                height: 20.0,
              ),
            TextField(decoration: textFieldDecoration.copyWith(hintText: 'last Name'),),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              decoration: textFieldDecoration.copyWith(hintText: 'Phone',),
              keyboardType:TextInputType.phone,
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
                keyboardType: TextInputType.emailAddress,
                decoration:textFieldDecoration.copyWith(hintText: 'Your Email' ),
                onChanged: (value){email=value;}
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              obscureText: true,
              decoration: textFieldDecoration.copyWith(hintText: 'Your password' ),
              onChanged: (value){password=value;},
            ),
            SizedBox(
              height: 20.0,
            ),
            CustomButton(
              title: 'Register',onPress: ()async{
              await registerUser();
            },),
          ],),
        ),
      ),
    );
  }
}
