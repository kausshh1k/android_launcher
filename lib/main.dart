import 'package:flutter/material.dart';
import 'package:launcher/pages/appscreen.dart';
import 'package:launcher/pages/homepage.dart';
import 'package:launcher/pages/listofapps.dart';
// import 'package:launcher/pages/listofapps.dart';
import 'package:launcher/pages/taskpage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return Future.value(false);
      },
      child: const MaterialApp(
        home: Scaffold(backgroundColor: Colors.black, body: MyAppBody()),
      ),
    );
  }
}

class MyAppBody extends StatefulWidget {
  const MyAppBody({super.key});

  @override
  State<MyAppBody> createState() => _MyAppBodyState();
}

class _MyAppBodyState extends State<MyAppBody> {
  int completedTasks = 0;
  int totalTasks = 0;
  List toDoList = [];
  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: const BouncingScrollPhysics(),
      onPageChanged: (index) {
        WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
      },
      children: [
        Main(
          completedTasks: completedTasks,
          totalTasks: totalTasks,
        ),
        Task(
          toDoList: toDoList,
          completedTasks: completedTasks,
          totalTasks: totalTasks,
        ),
        ListOfApps()
      ],
    );
  }
}
