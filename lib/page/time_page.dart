import 'package:flutter/material.dart';
import 'package:flutter_time_until/state/application_preferences.dart';
import 'package:flutter_time_until/time/time_until.dart';
import 'package:flutter_time_until/wigets/page_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';

class TimePage extends StatelessWidget {
  final String title;
  final DateTime selectedTime;
  final dateFormat = new DateFormat.yMd();
  final timeFormat = new DateFormat.Hm();
  final bool showSaveButton;

  TimePage(this.selectedTime,
      {this.title = 'Time Until', this.showSaveButton = false});

  final List<Tab> tabs = <Tab>[
    Tab(
      icon: Icon(Icons.query_builder),
      text: 'Common',
    ),
    Tab(
      icon: Icon(Icons.public),
      text: 'Ancient',
    ),
    Tab(
      icon: Icon(Icons.biotech),
      text: 'Scientifc',
    ),
  ];

  void _precisionChangeNotification(BuildContext context) {
    var state = context.read<ApplicationPreferences>();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Value precision is set to ${state.precision}'),
    ));
  }

  void _addPrecision(BuildContext context) {
    context.read<ApplicationPreferences>().incrementPrecision();
    _precisionChangeNotification(context);
  }

  void _removePrecision(BuildContext context) {
    context.read<ApplicationPreferences>().decrementPrecision();
    _precisionChangeNotification(context);
  }

  void _toggleTimer(BuildContext context) {
    var state = context.read<ApplicationPreferences>();
    state.toggleTimerUpdate();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: state.isTimerUpdate
          ? Text('Timer has been started')
          : Text('Timer has been paused'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          state.toggleTimerUpdate();
        },
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    var prefs = context.watch<ApplicationPreferences>();
    var calc = TimeUntil(prefs.now, this.selectedTime, prefs.precision);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          bottom: TabBar(
            tabs: tabs,
            indicatorColor: Theme.of(context).accentColor,
          ),
          actions: [
            Tooltip(
              message: 'Add precision',
              child: IconButton(
                icon: Icon(Icons.update),
                onPressed:
                    prefs.precision > 20 ? null : () => _addPrecision(context),
              ),
            ),
            Tooltip(
              message: 'Remove precision',
              child: IconButton(
                icon: Icon(Icons.restore),
                onPressed: prefs.precision < 2
                    ? null
                    : () => _removePrecision(context),
              ),
            ),
            Tooltip(
              message: prefs.isTimerUpdate ? 'Pause timer' : 'Start timer',
              child: IconButton(
                icon: prefs.isTimerUpdate
                    ? Icon(Icons.timer)
                    : Icon(Icons.timer_off),
                onPressed: () => _toggleTimer(context),
              ),
            ),
          ],
        ),
        body: Center(
          child: Container(
            margin: const EdgeInsets.all(4),
            child: TabBarView(
              children: [
                DisplayEntries(calc.common),
                DisplayEntries(calc.ancient),
                DisplayEntries(calc.scientific),
              ],
            ),
          ),
        ),
        floatingActionButton: this.showSaveButton
            ? FloatingActionButton.extended(
                label: Text('Save'),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddCountdownPage(selectedTime),
                      ));
                },
                backgroundColor: Colors.green,
                icon: Icon(Icons.save),
                tooltip: 'Save date',
              )
            : null,
      ),
    );
  }
}
