import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(), // Use a dark theme for better AMOLED experience
      home: const ClockScreen(),
    );
  }
}

class ClockScreen extends StatefulWidget {
  const ClockScreen({super.key});

  @override
  State<ClockScreen> createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {
  late Timer _timer;
  String _timeString = '';
  String _dateString = '';
  String _quarterString = '';

  @override
  void initState() {
    super.initState();
    _updateTime();
    _timer =
        Timer.periodic(const Duration(seconds: 1), (Timer t) => _updateTime());
  }

  void _updateTime() {
    final now = DateTime.now();
    setState(() {
      _timeString = DateFormat('HH:mm:ss').format(now);
      _dateString = DateFormat('EEE d MMM').format(now);
      _quarterString = _getQuarter(now); // Get the quarter and year
    });
  }

  // Function to get quarter and year
  String _getQuarter(DateTime date) {
    int month = date.month;
    int year = date.year;
    String quarter;

    if (month >= 1 && month <= 3) {
      quarter = 'Q1';
    } else if (month >= 4 && month <= 6) {
      quarter = 'Q2';
    } else if (month >= 7 && month <= 9) {
      quarter = 'Q3';
    } else {
      quarter = 'Q4';
    }

    return '$quarter $year'; // Return the quarter with the year
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // AMOLED black background
      body: Align(
        alignment: Alignment.centerLeft, // Align content to the left
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment:
                CrossAxisAlignment.start, // Align children to the left
            children: <Widget>[
              Text(
                _timeString,
                style: const TextStyle(fontSize: 100), // Large font for time
              ),
              const SizedBox(height: 5), // Adds space between time and date
              Text(
                _dateString,
                style: const TextStyle(fontSize: 35), // Medium font for date
              ),
              const SizedBox(
                  height: 2), // Adds space between date and quarter/year
              Text(
                _quarterString,
                style: const TextStyle(
                    fontSize:
                        25), // Medium font for quarter and yearhttps://github.com/Hxmbl/clock_app/new/main
              ),
            ],
          ),
        ),
      ),
    );
  }
}
