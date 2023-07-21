import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {required this.logRegistColors,
      required this.title,
      required this.onPressed});

  final String title;
  final Function onPressed;

  final List<Color> logRegistColors;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: () {
            onPressed();
          },
          minWidth: 200.0,
          height: 42.0,
          child: AnimatedTextKit(
            animatedTexts: [
              ColorizeAnimatedText(
                title,
                textStyle: const TextStyle(fontSize: 16),
                colors: logRegistColors,
                speed: const Duration(milliseconds: 250),
              ),
            ],
            totalRepeatCount: 1,
          ),
        ),
      ),
    );
  }
}
