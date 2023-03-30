import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:battery_plus/battery_plus.dart';
import 'dart:math';
import 'package:url_launcher/url_launcher.dart';

class Main extends StatefulWidget {
  // final String title;
  int completedTasks;
  int totalTasks;
  Main({required this.completedTasks, required this.totalTasks});

  @override
  _MainState createState() => _MainState(completedTasks: completedTasks, totalTasks: totalTasks);
}

class _MainState extends State<Main> {
  int completedTasks;
  int totalTasks;
  _MainState({required this.completedTasks, required this.totalTasks});

  String homeQuote = '';
  final homePageQuotes = ['Every action you take is a vote for the type of person you wish to become.', 'You do not rise to the level of your goals. You fall to the level of your systems.', 'You should be far more concerned with your current trajectory than with your current results.', 'Goals are good for setting a direction, but systems are best for making progress.', 'Habits are the compound interest of self-improvement', 'Be the designer of your world and not merely the consumer of it.', 'Winners and losers have the same goals.', 'Success is the product of daily habits—not once-in-a-lifetime transformations.', 'Professionals stick to the schedule\; amateurs let life get in the way.'];
  var battery = Battery();
  int percentage = 0;
  DateFormat dateFormat = DateFormat();
  String _currentTime = '';
  String _currentDate = '';
  String _hourString = '';
  String _dayString = '';
  String _weekString = '';
  String _monthString = '';
  String _yearString = '';
  String _yearDayCount = '';
  String _currentDayCount = '';
  var coffeeUrl = Uri(
    scheme: 'https',
    host: 'buymeacoffee.com',
  );

  @override
  void initState() {
    super.initState();
    // _hourString = _formatMinute(DateTime.now());
    // _dayString = _formatHour(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    Timer.periodic(Duration(hours: 1), (Timer t) => getQuote());
    // dateFormat = DateFormat.H();
    getBatteryPercentage();
    getQuote();
  }

  void getQuote() async {
    var rng = Random();
    int randInt = rng.nextInt(homePageQuotes.length);
    final quote = await homePageQuotes[randInt];
    homeQuote = quote;
    setState(() {});
  }

  //batter percentage function
  void getBatteryPercentage() async {
    final level = await battery.batteryLevel;
    percentage = level;

    setState(() {});
  }

  void goToCoffee() async {
    if (await canLaunchUrl(coffeeUrl)) {
      await launchUrl(coffeeUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    String time = _currentTime;
    String date = _currentDate;
    var hourPercent = (double.parse(_hourString) / 60) * 100;
    String hourPer = hourPercent.toStringAsFixed(0);
    var dayPercent = (((double.parse(_dayString) * 60) + double.parse(_hourString)) / (24 * 60)) * 100;
    String dayPer = dayPercent.toStringAsFixed(0);
    var weekPercent = ((double.parse(_weekString) + ((double.parse(_dayString) * 60) + double.parse(_hourString)) / (24 * 60)) / 7) * 100;
    String weekPer = weekPercent.toStringAsFixed(0);
    var monthPercent = (((double.parse(_monthString) + ((double.parse(_dayString) * 60) + double.parse(_hourString)) / (24 * 60))) / double.parse(_yearString)) * 100;
    String monthPer = monthPercent.toStringAsFixed(0);
    var yearPercent = (double.parse(_currentDayCount) + double.parse(_monthString)) / double.parse(_yearDayCount) * 100;
    String yearPer = yearPercent.toStringAsFixed(0);

    return Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
      Container(
        margin: EdgeInsets.zero,
        child: Column(children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.only(left: 50, right: 50, top: 50),
              child: Text(
                '$time',
                style: GoogleFonts.montserrat(textStyle: TextStyle(fontSize: 40, color: Colors.white)),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.only(left: 50, right: 50, top: 10),
              child: Text(
                '$date',
                style: GoogleFonts.montserrat(textStyle: TextStyle(fontSize: 20, color: Colors.white)),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.only(left: 50, right: 50, top: 10),
              child: Text(
                'Battery: $percentage%',
                style: GoogleFonts.montserrat(textStyle: TextStyle(fontSize: 12, color: Colors.white)),
              ),
            ),
          ),
          // Align(
          //   alignment: Alignment.centerLeft,
          //   child: Container(
          //     margin: const EdgeInsets.only(left: 50, right: 50, top: 20),
          //     child: Text(
          //       'Tasks completed: ${completedTasks}/${totalTasks}',
          //       style: GoogleFonts.montserrat(textStyle: TextStyle(fontSize: 14, color: Colors.white)),
          //     ),
          //   ),
          // ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(left: 50, right: 50, top: MediaQuery.of(context).size.height * 0.05),
              child: Text(
                'Hour in progress, $hourPer%',
                style: GoogleFonts.montserrat(textStyle: TextStyle(fontSize: 14, color: Colors.white)),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Color.fromRGBO(199, 199, 199, 1), width: 1),
            ),
            margin: const EdgeInsets.only(left: 50, right: 50, top: 4),
            child: LinearPercentIndicator(
              padding: EdgeInsets.zero,
              lineHeight: 14,
              percent: hourPercent / 100,
              barRadius: const Radius.circular(0),
              backgroundColor: Color.fromRGBO(22, 22, 22, 1),
              progressColor: Color.fromRGBO(217, 217, 217, 1),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(left: 50, right: 50, top: MediaQuery.of(context).size.height * 0.03),
              child: Text(
                'Day in progress, $dayPer%',
                style: GoogleFonts.montserrat(textStyle: TextStyle(fontSize: 14, color: Colors.white)),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Color.fromRGBO(199, 199, 199, 1), width: 1),
            ),
            margin: const EdgeInsets.only(left: 50, right: 50, top: 4),
            child: LinearPercentIndicator(
              padding: EdgeInsets.zero,
              lineHeight: 14,
              percent: dayPercent / 100,
              barRadius: const Radius.circular(0),
              backgroundColor: Color.fromRGBO(22, 22, 22, 1),
              progressColor: Color.fromRGBO(217, 217, 217, 1),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(left: 50, right: 50, top: MediaQuery.of(context).size.height * 0.03),
              child: Text(
                'Week in progress, $weekPer%',
                style: GoogleFonts.montserrat(textStyle: TextStyle(fontSize: 14, color: Colors.white)),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Color.fromRGBO(199, 199, 199, 1), width: 1),
            ),
            margin: const EdgeInsets.only(left: 50, right: 50, top: 4),
            child: LinearPercentIndicator(
              padding: EdgeInsets.zero,
              lineHeight: 14,
              percent: weekPercent / 100,
              barRadius: const Radius.circular(0),
              backgroundColor: Color.fromRGBO(22, 22, 22, 1),
              progressColor: Color.fromRGBO(217, 217, 217, 1),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(left: 50, right: 50, top: MediaQuery.of(context).size.height * 0.03),
              child: Text(
                'Month in progress, $monthPer%',
                style: GoogleFonts.montserrat(textStyle: TextStyle(fontSize: 14, color: Colors.white)),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Color.fromRGBO(199, 199, 199, 1), width: 1),
            ),
            margin: const EdgeInsets.only(left: 50, right: 50, top: 4),
            child: LinearPercentIndicator(
              padding: EdgeInsets.zero,
              lineHeight: 14,
              percent: monthPercent / 100,
              barRadius: const Radius.circular(0),
              backgroundColor: Color.fromRGBO(22, 22, 22, 1),
              progressColor: Color.fromRGBO(217, 217, 217, 1),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(left: 50, right: 50, top: MediaQuery.of(context).size.height * 0.03),
              child: Text(
                'Year in progress, $yearPer%',
                style: GoogleFonts.montserrat(textStyle: TextStyle(fontSize: 14, color: Colors.white)),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Color.fromRGBO(199, 199, 199, 1), width: 1),
            ),
            margin: const EdgeInsets.only(left: 50, right: 50, top: 4),
            child: LinearPercentIndicator(
              padding: EdgeInsets.zero,
              lineHeight: 14,
              percent: yearPercent / 100,
              barRadius: const Radius.circular(0),
              backgroundColor: Color.fromRGBO(22, 22, 22, 1),
              progressColor: Color.fromRGBO(217, 217, 217, 1),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(left: 50, right: 50, top: MediaQuery.of(context).size.height * 0.06, bottom: 20),
              child: Text(
                '"$homeQuote"',
                style: GoogleFonts.montserrat(textStyle: TextStyle(fontSize: 14, color: Colors.white)),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 50, right: 50, top: MediaQuery.of(context).size.height * 0.01, bottom: 20),
            child: TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
              ),
              onPressed: goToCoffee,
              child: Text(
                'Buy me a coffee ↗️',
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(fontSize: 14, color: Colors.white, decoration: TextDecoration.underline, decorationThickness: 2),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ]),
      ),
    ]);
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedTime = _formatTime(now);
    final String formattedDate = _formatDate(now);
    final String formattedMinute = _formatMinute(now);
    final String formattedHour = _formatHour(now);
    final String formattedDay = _formatDay(now);
    final String formattedWeek = _formatWeek(now);
    final String formattedMonth = _formatMonth(now);
    final String formattedcurrentDayCount = _formatcurrentDayCount(now);
    final String formattedyearDayCount = _formatyearDayCount(now);
    setState(() {
      _currentTime = formattedTime;
      _currentDate = formattedDate;
      _hourString = formattedMinute;
      _dayString = formattedHour;
      _weekString = formattedDay;
      _monthString = formattedWeek;
      _yearString = formattedMonth;
      _currentDayCount = formattedcurrentDayCount;
      _yearDayCount = formattedyearDayCount;
    });
  }

  String _formatTime(DateTime dateTime) {
    return DateFormat('HH:mm').format(dateTime);
  }

  String _formatDate(DateTime dateTime) {
    return DateFormat('EEEE, MMMM dd').format(dateTime);
  }

  String _formatMinute(DateTime dateTime) {
    return DateFormat('m').format(dateTime);
  }

  String _formatHour(DateTime dateTime) {
    return DateFormat.H().format(dateTime);
  }

  String _formatDay(DateTime dateTime) {
    var day = DateFormat('EEEE').format(dateTime);
    if (day == 'Monday') {
      return '0';
    } else if (day == 'Tuesday') {
      return '1';
    } else if (day == 'Wednesday') {
      return '2';
    } else if (day == 'Thursday') {
      return '3';
    } else if (day == 'Friday') {
      return '4';
    } else if (day == 'Saturday') {
      return '5';
    } else {
      return '6';
    }
  }

  String _formatWeek(DateTime dateTime) {
    return DateFormat('dd').format(dateTime);
  }

  String _formatMonth(DateTime dateTime) {
    var month = DateFormat('MM').format(dateTime);
    var year = double.parse(DateFormat('yyyy').format(dateTime));
    if (['01', '03', '05', '07', '08', '10', '12'].contains(month)) {
      return '31';
    } else if (['04', '06', '09', '11'].contains(month)) {
      return '30';
    } else {
      return (((year % 4 == 0) & (year % 100 == 0) & (year % 400 == 0)) ? '29' : '28');
    }
  }

  String _formatcurrentDayCount(DateTime dateTime) {
    var month = DateFormat('MM').format(dateTime);
    var year = double.parse(DateFormat('yyyy').format(dateTime));
    if (month == '01') {
      return '${0}';
    } else if (month == '02') {
      return '${31}';
    } else if (month == '03') {
      return '${31 + (((year % 4 == 0) & (year % 100 == 0) & (year % 400 == 0)) ? 29 : 28)}';
    } else if (month == '04') {
      return '${31 + (((year % 4 == 0) & (year % 100 == 0) & (year % 400 == 0)) ? 29 : 28) + 31}';
    } else if (month == '05') {
      return '${31 + (((year % 4 == 0) & (year % 100 == 0) & (year % 400 == 0)) ? 29 : 28) + 31 + 30}';
    } else if (month == '06') {
      return '${31 + (((year % 4 == 0) & (year % 100 == 0) & (year % 400 == 0)) ? 29 : 28) + 31 + 30 + 31}';
    } else if (month == '07') {
      return '${31 + (((year % 4 == 0) & (year % 100 == 0) & (year % 400 == 0)) ? 29 : 28) + 31 + 30 + 31 + 30}';
    } else if (month == '08') {
      return '${31 + (((year % 4 == 0) & (year % 100 == 0) & (year % 400 == 0)) ? 29 : 28) + 31 + 30 + 31 + 30 + 31}';
    } else if (month == '09') {
      return '${31 + (((year % 4 == 0) & (year % 100 == 0) & (year % 400 == 0)) ? 29 : 28) + 31 + 30 + 31 + 30 + 31 + 31}';
    } else if (month == '10') {
      return '${31 + (((year % 4 == 0) & (year % 100 == 0) & (year % 400 == 0)) ? 29 : 28) + 31 + 30 + 31 + 30 + 31 + 31 + 30}';
    } else if (month == '11') {
      return '${31 + (((year % 4 == 0) & (year % 100 == 0) & (year % 400 == 0)) ? 29 : 28) + 31 + 30 + 31 + 30 + 31 + 31 + 30 + 31}';
    } else {
      return '${31 + (((year % 4 == 0) & (year % 100 == 0) & (year % 400 == 0)) ? 29 : 28) + 31 + 30 + 31 + 30 + 31 + 31 + 30 + 31 + 30}';
    }
  }

  String _formatyearDayCount(DateTime dateTime) {
    var year = double.parse(DateFormat('yyyy').format(dateTime));
    return (((year % 4 == 0) & (year % 100 == 0) & (year % 400 == 0)) ? '366' : '365');
  }
}
