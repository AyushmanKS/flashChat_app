import 'dart:ui';

import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/rounded_buttons.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  Animation? logoAnimation;
  Animation? backgroundTween;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);

    logoAnimation =
        CurvedAnimation(parent: controller, curve: Curves.bounceOut);

    backgroundTween = ColorTween(
            begin: Colors.transparent,
            end: const Color.fromARGB(255, 203, 222, 255))
        .animate(controller);

    controller.forward();

    controller.addListener(() {
      setState(() {});
      print(logoAnimation!.value);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Colors for 'Flash Chat'
    const flashChatColors = [
      Colors.purple,
      Colors.black,
      Colors.yellowAccent,
      Colors.yellow,
      Color.fromARGB(255, 234, 210, 0),
    ];
    const logRegistColors = [
      Colors.black,
      Colors.black,
      Colors.yellow,
      Colors.purple,
      Colors.yellowAccent,
    ];

    return Scaffold(
      backgroundColor: backgroundTween!.value,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    height: logoAnimation!.value * 80,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                // Using AnimatedTextKit
                AnimatedTextKit(
                  animatedTexts: [
                    ColorizeAnimatedText(
                      'Flash Chat',
                      textStyle: const TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                      ),
                      colors: flashChatColors,
                      speed: const Duration(milliseconds: 250),
                    ),
                  ],
                  totalRepeatCount: 1,
                ),
              ],
            ),
            const SizedBox(height: 48.0),
            RoundedButton(
              logRegistColors: logRegistColors,
              title: 'Log in',
              onPressed: () {
                print('Log in button Tapped');
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            RoundedButton(
              logRegistColors: logRegistColors,
              title: 'Register',
              onPressed: () {
                print('Register Button Tapped');
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
