import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyButton extends StatelessWidget {
  final String text;
  VoidCallback onPressed;
  MyButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Colors.white,
      child: Text(
        text,
        style: GoogleFonts.montserrat(
          textStyle: TextStyle(fontSize: 16, color: Colors.black),
        ),
      ),
    );
  }
}
