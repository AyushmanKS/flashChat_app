import 'package:flash_chat/components/rounded_buttons.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
      //   title: const Text('Login Page'),
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
                // storing email
                onChanged: (value) {
                  email = value;
                  print('LoginScreen Email: ' + email.toString());
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter your Email'),
              ),
              const SizedBox(height: 8.0),
              TextField(
                // storing password
                onChanged: (value) {
                  password = value;
                  print('LoginScreen Password: ' + password.toString());
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter Password'),
              ),
              const SizedBox(height: 24.0),
              RoundedButton(
                logRegistColors: logRegistColors,
                title: 'Login',
                onPressed: () async {
                  // authenticating user details
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    // Signing In existing user
                    await _auth.signInWithEmailAndPassword(
                        email: email!, password: password!);

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
