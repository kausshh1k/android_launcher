import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:launcher_assist/launcher_assist.dart';

class AppsScreen extends StatefulWidget {
  const AppsScreen({super.key});

  @override
  State<AppsScreen> createState() => _AppsScreenState();
}

class _AppsScreenState extends State<AppsScreen> {
  var installedApps;
  var focusNode1 = FocusNode();
  final _controller = TextEditingController();

  // void stopApp() {
  //   const oneMin = const Duration(minutes: 1);
  //   SystemNavigator.pop();
  // }

  @override
  void initState() async {
    super.initState();
    List<Application> apps = await DeviceApps.getInstalledApplications(onlyAppsWithLaunchIntent: true, includeSystemApps: true);
    // apps.sort((a, b) => a.appName.toLowerCase().compareTo(b.appName.toLowerCase()));
    installedApps = apps;
  }

  @override
  Widget build(BuildContext context) {
    //
    //
    //
    //listOfApps
    //
    return Scaffold(
      body: ListView.builder(
          itemCount: installedApps.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: Padding(
                padding: const EdgeInsets.only(top: 23, left: 50, right: 50),
                child: Column(
                  children: [
                    Text(
                      '${installedApps[index].appName}',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
