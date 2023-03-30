import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function()? deleteTask;

  ToDoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteTask,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
      child: Container(
        child: Container(
          decoration: BoxDecoration(color: taskCompleted ? Color.fromRGBO(9, 9, 9, 1) : Color.fromRGBO(19, 19, 19, 1), borderRadius: BorderRadius.all(Radius.circular(2))),
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //checkbox
              Row(
                children: [
                  Transform.scale(
                    scale: 1.8,
                    child: Checkbox(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                      side: BorderSide(color: Color.fromRGBO(50, 50, 50, 1)),
                      checkColor: Colors.black,
                      activeColor: Color.fromRGBO(50, 50, 50, 1),
                      value: taskCompleted,
                      onChanged: onChanged,
                    ),
                  ),
                  //task
                  Container(
                    child: Text(
                      taskName,
                      overflow: TextOverflow.visible,
                      style: GoogleFonts.montserrat(textStyle: TextStyle(fontSize: 30, color: taskCompleted ? Color.fromRGBO(57, 57, 57, 1) : Colors.white, decoration: taskCompleted ? TextDecoration.lineThrough : TextDecoration.none)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1000)),
                minWidth: 40,
                height: 55,
                onPressed: deleteTask,
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
