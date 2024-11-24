import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clock App',
      theme: ThemeData.dark(), // Use a dark theme for better AMOLED experience
      home: ClockScreen(),
    );
  }
}

class ClockScreen extends StatefulWidget {
  @override
  _ClockScreenState createState() => _ClockScreenState();
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
    _timer = Timer.periodic(Duration(seconds: 1), (Timer t) => _updateTime());
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
      appBar: AppBar(
        title: Text('Clock App'),
        backgroundColor: Colors.black, // Black app bar
      ),
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
                style: TextStyle(fontSize: 100), // Large font for time
              ),
              SizedBox(height: 5), // Adds space between time and date
              Text(
                _dateString,
                style: TextStyle(fontSize: 35), // Medium font for date
              ),
              SizedBox(height: 2), // Adds space between date and quarter/year
              Text(
                _quarterString,
                style:
                    TextStyle(fontSize: 25), // Medium font for quarter and year
              ),
            ],
          ),
        ),
      ),
    );
  }
}
