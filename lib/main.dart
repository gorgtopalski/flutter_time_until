import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_time_until/time_calculator.dart';
import 'package:flutter_time_until/wigets/page_widget.dart';

import 'common/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time Until',
      theme: ApplicationTheme(isDark: false).themeData,
      home: MyHomePage(title: 'Time Until'),
      debugShowCheckedModeBanner: false,
    );
  }
}

enum PopUpCommands { dark, increment, decrement }

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
  int _precision = 2;
  bool _dark = false;

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
        actions: [
          Builder(
            builder: (context) => PopupMenuButton<PopUpCommands>(
              onSelected: (PopUpCommands result) {
                print(_precision);
                switch (result) {
                  case PopUpCommands.dark:
                    setState(() {
                      _dark = !_dark;
                    });
                    break;
                  case PopUpCommands.increment:
                    if (_precision < 5) {
                      setState(() {
                        _precision++;
                      });
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('Value precision is set to $_precision'),
                        duration: Duration(seconds: 1),
                      ));
                    }
                    break;
                  case PopUpCommands.decrement:
                    if (_precision > 1) {
                      setState(() {
                        _precision--;
                      });
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('Value precision is set to $_precision'),
                        duration: Duration(seconds: 1),
                      ));
                    }
                    break;
                }
              },
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<PopUpCommands>>[
                PopupMenuItem<PopUpCommands>(
                  enabled: _precision < 5,
                  value: PopUpCommands.increment,
                  child: ListTile(
                    leading: Icon(Icons.add),
                    title: Text('Add precision'),
                  ),
                ),
                PopupMenuItem<PopUpCommands>(
                  enabled: _precision > 0,
                  value: PopUpCommands.decrement,
                  child: ListTile(
                    leading: Icon(Icons.remove),
                    title: Text('Remove precision'),
                  ),
                ),
                PopupMenuDivider(),
                CheckedPopupMenuItem<PopUpCommands>(
                  value: PopUpCommands.dark,
                  child: const Text('Dark Mode'),
                  checked: _dark,
                ),
              ],
            ),
          )
        ],
      ),
      body: Center(
          child: _isSelected
              ? PageBuilder(TimeCalculator(_now, _selected, _precision))
              : Text(
                  'Please select a date',
                  style: Theme.of(context).textTheme.headline3,
                )),
      floatingActionButton: FloatingActionButton(
        onPressed: _showDatePicker,
        tooltip: 'Select a date',
        child: Icon(Icons.date_range),
      ),
    );
  }
}
