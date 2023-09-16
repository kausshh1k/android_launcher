import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:launcher/util/todotile.dart';
import 'package:launcher/util/dialogbox.dart';
import 'package:launcher/pages/homepage.dart';

class Task extends StatefulWidget {
  List toDoList;
  int completedTasks;
  int totalTasks;
  Task({required this.toDoList, required this.completedTasks, required this.totalTasks});

  @override
  State<Task> createState() => _TaskState(toDoList: toDoList, completedTasks: completedTasks, totalTasks: totalTasks);
}

class _TaskState extends State<Task> {
  List toDoList;
  int completedTasks;
  int totalTasks;
  _TaskState({required this.toDoList, required this.completedTasks, required this.totalTasks});

  
  final _controller = TextEditingController();

  void saveNewTask() {
    setState(() {
      if (_controller.text != '') {
        toDoList.add([_controller.text, false]);
        _controller.clear();
        Navigator.of(context).pop();
      }
    });
  }

  //checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
      if (toDoList[index][1] == true) {
        completedTasks++;
      } else {
        completedTasks--;
      }
    });
    // Navigator.push(context, MaterialPageRoute(builder: (context) => Main(completedTasks: completedTasks, totalTasks: totalTasks)));
  }

  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        });

    totalTasks++;
    // Navigator.push(context, MaterialPageRoute(builder: (context) => Main(completedTasks: completedTasks, totalTasks: totalTasks)));
  }

  //deleting the task
  void deleteTask(index) {
    setState(() {
      if (toDoList[index][1] == true) {
        completedTasks--;
      }
      totalTasks--;
      toDoList.removeAt(index);
    });
    // Navigator.push(context, MaterialPageRoute(builder: (context) => Main(completedTasks: completedTasks, totalTasks: totalTasks)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Column(
          children: <Widget>[
            Text(
              'Tasks',
              style: GoogleFonts.montserrat(textStyle: TextStyle(fontSize: 30, color: Colors.white)),
              // maxLines: 5,
            ),
          ],
        ),
        centerTitle: true,
      ),
      floatingActionButton: SizedBox(
          width: 80,
          height: 80,
          child: FloatingActionButton.large(
            backgroundColor: Color.fromRGBO(19, 19, 19, 1),
            onPressed: createNewTask,
            child: Icon(Icons.add),
          )),
      backgroundColor: Colors.black,
      body: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: toDoList[index][0],
            taskCompleted: toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteTask: () => deleteTask(index),
          );
        },
      ),
    );
  }
}
