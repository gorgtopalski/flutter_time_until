import 'package:flutter/material.dart';
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
          Builder(
            builder: (context) => PopupMenuButton<PopUpCommands>(
              onSelected: (PopUpCommands result) {
                switch (result) {
                  case PopUpCommands.dark:
                    state.changeTheme(!state.darkTheme);
                    break;
                  case PopUpCommands.increment:
                    if (state.precision < 5) {
                      state.updatePrecission(state.precision + 1);
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text(
                            'Value precision is set to ${state.precision}'),
                        duration: Duration(seconds: 1),
                      ));
                    }
                    break;
                  case PopUpCommands.decrement:
                    if (state.precision > 1) {
                      state.updatePrecission(state.precision - 1);
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text(
                            'Value precision is set to ${state.precision}'),
                        duration: Duration(seconds: 1),
                      ));
                    }
                    break;
                  case PopUpCommands.time:
                    state.showTimePicker(!state.showTime);
                    break;
                }
              },
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<PopUpCommands>>[
                PopupMenuItem<PopUpCommands>(
                  enabled: state.precision < 5,
                  value: PopUpCommands.increment,
                  child: ListTile(
                    leading: Icon(Icons.add),
                    title: Text('Add precision'),
                  ),
                ),
                PopupMenuItem<PopUpCommands>(
                  enabled: state.precision > 0,
                  value: PopUpCommands.decrement,
                  child: ListTile(
                    leading: Icon(Icons.remove),
                    title: Text('Remove precision'),
                  ),
                ),
                PopupMenuDivider(),
                CheckedPopupMenuItem<PopUpCommands>(
                  value: PopUpCommands.time,
                  child: const Text('Allow time selection'),
                  checked: state.showTime,
                ),
                PopupMenuDivider(),
                CheckedPopupMenuItem<PopUpCommands>(
                  value: PopUpCommands.dark,
                  child: const Text('Dark Mode'),
                  checked: state.darkTheme,
                ),
              ],
            ),
          )
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
