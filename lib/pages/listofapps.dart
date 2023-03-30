import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:launcher_assist/launcher_assist.dart';

class ListOfApps extends StatefulWidget {
  const ListOfApps({super.key});

  @override
  State<ListOfApps> createState() => _ListOfAppsState();
}

class _ListOfAppsState extends State<ListOfApps> {
  var installedApps;
  var focusNode1 = FocusNode();
  final _controller = TextEditingController();

  void stopApp() {
    const oneMin = const Duration(minutes: 1);
    SystemNavigator.pop();
  }

  @override
  void initState() {
    super.initState();
    LauncherAssist.getAllApps().then((var apps) {
      setState(() {
        installedApps = apps;
        // var newList = apps.sort((a, b) => a.label.toString().compareTo(b.label.toString()));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //
    //
    //
    //listOfApps
    //
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: TextField(
            focusNode: focusNode1,
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(fontSize: 14, color: Colors.white),
            ),
            onSubmitted: ((value) {
              focusNode1.unfocus();
            }),
            controller: _controller,
            onChanged: (text) {
              if (text == '' || text == null) {
                LauncherAssist.getAllApps().then((var apps) {
                  setState(() {
                    installedApps = apps;
                  });
                });
              } else {
                LauncherAssist.getAllApps().then((var apps) {
                  setState(() {
                    installedApps = apps;
                    List searchApps = [];

                    for (var app in installedApps) {
                      if (app['label'].toLowerCase().startsWith(text.toLowerCase())) {
                        searchApps.add(app);
                      }
                    }
                    installedApps = searchApps;
                  });
                });
              }
            },
            cursorColor: Colors.white,
            decoration: InputDecoration(
              hintText: 'Search Apps',
              hintStyle: TextStyle(fontSize: 14, color: Colors.white),
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          )),
      backgroundColor: Colors.black,
      body: installedApps != null
          ? ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: installedApps.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 23, left: 50, right: 50),
                    child: Text(
                      '${installedApps[index]['label']}',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  onTap: () {
                    LauncherAssist.launchApp(installedApps[index]['package']);
                    stopApp();
                  },
                );
              },
            )
          : Container(
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
    );
  }
}
