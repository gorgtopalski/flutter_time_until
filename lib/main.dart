import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_time_until/time_calculator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time Until',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Time Until'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime _now;
  DateTime _selected;
  bool _isSelected = false;

  _MyHomePageState() {
    _now = DateTime.now();
    Timer.periodic(Duration(seconds: 1), _timerCallback);
  }

  //Updatres current date every second.
  //Used to simulate the countdown
  void _timerCallback(Timer t) {
    setState(() {
      _now = DateTime.now();
    });
  }

  //Shows the DatePicker widget and updates the state if one is selected
  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: _now,
            firstDate: _now,
            lastDate: DateTime.utc(DateTime.now().year + 50))
        .then((value) => {
              if (value != null)
                {
                  _selected = value,
                  _isSelected = true,
                }
            })
        .whenComplete(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.date_range),
        title: Text(widget.title),
      ),
      body: Center(
          child: _isSelected
              ? Result(_now, _selected)
              : Text('Please select a date')),
      floatingActionButton: FloatingActionButton(
        onPressed: _showDatePicker,
        tooltip: 'Select a date',
        child: Icon(Icons.date_range),
      ),
    );
  }
}

class Result extends StatelessWidget {
  final DateTime _now;
  final DateTime _selected;

  Result(this._now, this._selected);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '${TimeCalc.diffInYears(_now, _selected)} years',
            style: Theme.of(context).textTheme.headline2,
          ),
          Text(
            '${TimeCalc.diffInMonths(_now, _selected)} months',
            style: Theme.of(context).textTheme.headline2,
          ),
          Text(
            '${TimeCalc.diffInWeeks(_now, _selected)} weeks',
            style: Theme.of(context).textTheme.headline2,
          ),
          Text(
            '${TimeCalc.diffInDays(_now, _selected)} days',
            style: Theme.of(context).textTheme.headline2,
          ),
          Text(
            '${TimeCalc.diffInHours(_now, _selected)} hours',
            style: Theme.of(context).textTheme.headline2,
          ),
          Text(
            '${TimeCalc.diffInMinutes(_now, _selected)} minutes',
            style: Theme.of(context).textTheme.headline2,
          ),
          Text(
            '${TimeCalc.diffInSeconds(_now, _selected)} seconds',
            style: Theme.of(context).textTheme.headline2,
          ),
          Text(
            '${TimeCalc.diffInMedievalMoment(_now, _selected)} moments',
            style: Theme.of(context).textTheme.headline2,
          ),
          Text(
            '${TimeCalc.diffInKe(_now, _selected)} ke',
            style: Theme.of(context).textTheme.headline2,
          ),
          Text(
            '${TimeCalc.diffInElectronicsJiffy(_now, _selected)} jiffies',
            style: Theme.of(context).textTheme.headline2,
          ),
          Text(
            '${TimeCalc.diffInPhysicsJiffy(_now, _selected)} jiffies',
            style: Theme.of(context).textTheme.headline2,
          ),
          Text(
            '${TimeCalc.diffInLustrum(_now, _selected)} lustrums',
            style: Theme.of(context).textTheme.headline2,
          ),
          Text(
            '${TimeCalc.diffInDecades(_now, _selected)} decades',
            style: Theme.of(context).textTheme.headline2,
          ),
          Text(
            '${TimeCalc.diffInCenturies(_now, _selected)} centuries',
            style: Theme.of(context).textTheme.headline2,
          ),
          Text(
            '${TimeCalc.diffInMillennia(_now, _selected)} millenia',
            style: Theme.of(context).textTheme.headline2,
          ),
          Text(
            '${TimeCalc.diffInMegannum(_now, _selected)} meganum',
            style: Theme.of(context).textTheme.headline2,
          ),
          Text(
            '${TimeCalc.diffInGalacticYear(_now, _selected)} galactic years',
            style: Theme.of(context).textTheme.headline2,
          ),
          Text(
            '${TimeCalc.diffInPlankTime(_now, _selected)} plank time unit',
            style: Theme.of(context).textTheme.headline2,
          ),
        ],
      ),
    );
  }
}
