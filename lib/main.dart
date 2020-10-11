import 'package:flutter/material.dart';
import 'package:flutter_time_until/wigets/popup_menu.dart';
import 'package:provider/provider.dart';

import 'application_state.dart';
import 'common/theme.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => ApplicationState(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time Until',
      theme:
          ApplicationTheme(isDark: context.watch<ApplicationState>().darkTheme)
              .themeData,
      home: HomePage('Time Until'),
      debugShowCheckedModeBanner: false,
    );
  }
}

enum PopUpCommands { dark, increment, decrement, time }

class HomePage extends StatelessWidget {
  final String title;

  HomePage(this.title);

  //Shows the DatePicker widget and updates the state if one is selected
  void _showDatePicker(BuildContext context, ApplicationState state) {
    if (state.showTime) {
      showTimePicker(
              context: context, initialTime: TimeOfDay(hour: 0, minute: 0))
          .then((value) => state.addTimeToSelectedDate(value));
    }

    showDatePicker(
      context: context,
      initialDate: state.now,
      firstDate: state.now,
      lastDate: DateTime.utc(state.now.year + 50),
    ).then((value) => {state.setSelectedDate(value)});
  }

  @override
  Widget build(BuildContext context) {
    var state = context.watch<ApplicationState>();

    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.date_range),
        title: Text(
          title + (state.isSelected ? ' ' + state.selected.toString() : ''),
          textAlign: TextAlign.justify,
        ),
        bottom: state.isSelected ? state.tabBuilder.getTabBar(context) : null,
        actions: [
          ApplicationPopUpMenu(),
        ],
      ),
      body: Center(
          child: state.isSelected
              ? state.tabBuilder.build(context)
              : Text(
                  'Please select a date',
                  style: Theme.of(context).textTheme.headline4,
                )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {_showDatePicker(context, state)},
        tooltip: 'Select a date',
        child: Icon(Icons.date_range),
      ),
    );
  }
}
