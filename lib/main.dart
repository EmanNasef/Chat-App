import 'package:flutter/material.dart';
import 'package:chat/chat.dart';
import 'package:chat/login.dart';
import 'package:chat/register.dart';
import 'button.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Chat',
      //theme: ThemeData.dark(),
      initialRoute: MyHomePage.id,
      routes: {
        MyHomePage.id: (context) => MyHomePage(),
        LoginScreen.id: (context) => LoginScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        ChatScreen.id: (context) => ChatScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  static const String id = 'home';
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController myController;
  Animation myAnimation;

  @override
  void initState() {
    super.initState();
    myController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    myController.forward();
    // myController.reverse(from: 1.0);
    myController.addListener(() {
      // print(myController.value);
      setState(() {});
    });

    myAnimation =
        CurvedAnimation(parent: myController, curve: Curves.decelerate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Image(
                    image: AssetImage('images/chat.jpg'),
                    height: myAnimation.value * 200,
                  ),
                ),
              ),
              CustomButton(
                title: 'Log In',
                onPress: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
              ),
              SizedBox(height: 20.0),
              CustomButton(
                title: 'Register',
                onPress: () {
                  Navigator.pushNamed(context, RegisterScreen.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
