import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.boxHeight,
      required this.boxWidth,
      required this.fontSize});

  final String text;

  final onPressed;
  final double boxHeight; //53
  final double boxWidth; //200
  final double fontSize; //18

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: boxHeight,
      width: boxWidth,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.yellow.shade800,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontSize: fontSize,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
