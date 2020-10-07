import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_time_until/time_calculator.dart';

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
              ? PageResult(TimeCalculator(_now, _selected, 4))
              : Text('Please select a date')),
      floatingActionButton: FloatingActionButton(
        onPressed: _showDatePicker,
        tooltip: 'Select a date',
        child: Icon(Icons.date_range),
      ),
    );
  }
}

class PageResult extends StatelessWidget {
  final controller = PageController(initialPage: 0);

  final TimeCalculator _calc;

  PageResult(this._calc);

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller,
      children: [
        PageWidget(
          title: 'Common',
          titleIcon: Icons.query_builder,
          entries: _calc.common,
        ),
        PageWidget(
          title: 'Ancient',
          titleIcon: Icons.public,
          entries: _calc.ancient,
        ),
        PageWidget(
          title: 'Scientifc',
          titleIcon: Icons.biotech,
          entries: _calc.scientific,
        )
      ],
    );
  }
}

class PageWidget extends StatelessWidget {
  final String title;
  final IconData titleIcon;
  final Map<String, String> entries;

  PageWidget({this.entries, this.title, this.titleIcon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TitleWithEmoji(title: title, icon: titleIcon),
          SizedBox(
            height: 25,
          ),
          DisplayEntries(entries)
        ],
      )),
    );
  }
}

class TitleWithEmoji extends StatelessWidget {
  final String title;
  final IconData icon;

  TitleWithEmoji({this.title, this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline1,
        ),
        SizedBox(
          width: 20,
        ),
        Icon(icon,
            color: Theme.of(context).textTheme.headline1.color,
            size: Theme.of(context).textTheme.headline1.fontSize)
      ],
    );
  }
}

class DisplayEntries extends StatelessWidget {
  final Map<String, String> entries;

  DisplayEntries(this.entries);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: entries.keys
          .map((key) => Text(
                entries[key] + ' ' + key,
                style: Theme.of(context).textTheme.headline2,
              ))
          .toList(),
    );
  }
}
