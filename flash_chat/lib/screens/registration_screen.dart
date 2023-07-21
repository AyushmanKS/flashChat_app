//import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
//import 'package:flash_chat/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/rounded_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // to authenticate user (email and password)=> details
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    const logRegistColors = [
      Colors.black,
      Colors.black,
      Colors.yellow,
      Colors.purple,
      Colors.yellowAccent,
    ];

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Register Screen'),
      // ),
      backgroundColor: Colors.blue,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
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
              const SizedBox(height: 48.0),
              TextField(
                // for email type keyboard
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,

                // inputted email value stored here
                onChanged: (value) {
                  email = value;
                  print('Registration Screen: ' + email.toString());
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter your Email'),
              ),
              const SizedBox(height: 8.0),
              TextField(
                // to hide password
                obscureText: true,

                textAlign: TextAlign.center,
                // inputted password value stored here
                onChanged: (value) {
                  password = value;
                  print('Registration Screen: ' + password.toString());
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter Password'),
              ),
              const SizedBox(height: 24.0),
              RoundedButton(
                logRegistColors: logRegistColors,
                title: 'Register',
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    // stories value in _auth firebase
                    await _auth.createUserWithEmailAndPassword(
                        email: email!, password: password!);

                    //if (newUser != null) {

                    // Navigating to ChatScreen
                    Navigator.pushNamed(context, ChatScreen.id);

                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    print(e);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
