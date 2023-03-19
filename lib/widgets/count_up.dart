import 'dart:async';
import 'package:flutter/material.dart';

class CountupTimer extends StatefulWidget {
  CountupTimer({super.key});
  @override
  _CountupTimerState createState() => _CountupTimerState();
}

class _CountupTimerState extends State<CountupTimer> {
  late Timer _timer;
  int _secondsRemaining = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _secondsRemaining++;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int minutes = (_secondsRemaining ~/ 60);
    int seconds = (_secondsRemaining % 60);

    return Text(
        "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}");
  }
}
