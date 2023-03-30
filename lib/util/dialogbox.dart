import 'package:flutter/material.dart';
import 'package:launcher/util/mybutton.dart';
import 'package:google_fonts/google_fonts.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;
  DialogBox({super.key, required this.controller, required this.onSave, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromRGBO(19, 19, 19, 1),
      content: Container(
        height: 120,
        //user input
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(fontSize: 16, color: Colors.white),
              ),
              controller: controller,
              cursorColor: Colors.white,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            //buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton(text: 'save', onPressed: onSave),
                const SizedBox(width: 10),
                MyButton(text: 'cancel', onPressed: onCancel),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
