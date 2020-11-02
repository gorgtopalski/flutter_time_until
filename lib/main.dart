import 'package:flutter/material.dart';
import 'package:flutter_time_until/wigets/popup_menu.dart';
//import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart';
import 'package:provider/provider.dart';

import 'application_state.dart';
import 'common/theme.dart';

void main() {
  findSystemLocale()
      .then((value) => {
            Intl.defaultLocale = value,
            initializeDateFormatting(),
          })
      .whenComplete(() => runApp(ChangeNotifierProvider(
          create: (context) => ApplicationState(), child: MyApp())));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme =
        ApplicationTheme(isDark: context.watch<ApplicationState>().darkTheme)
            .themeData;

    return MaterialApp(
      title: 'Time Until',
      theme: theme,
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  final String title = 'Time Until';
  final dateFormat = new DateFormat.yMd();
  final timeFormat = new DateFormat.Hm();

  //Shows the DatePicker widget and updates the state if one is selected
  void _showDatePicker(BuildContext context, ApplicationState state) {
    if (state.showTime) {
      showDatePicker(
        context: context,
        initialDate: state.now,
        firstDate: state.now,
        lastDate: DateTime.utc(state.now.year + 50),
      ).then((date) => {
            showTimePicker(
                    context: context,
                    initialTime: TimeOfDay(hour: 0, minute: 0))
                .then((time) => state.setSelectedDate(date, time))
          });
    } else {
      showDatePicker(
        context: context,
        initialDate: state.now,
        firstDate: state.now,
        lastDate: DateTime.utc(state.now.year + 50),
      ).then((value) => {state.setSelectedDate(value)});
    }
  }

  String _generateTitle(DateTime selected, [bool displayTime = false]) {
    if (selected == null) {
      return title;
    } else {
      if (displayTime) {
        return 'Time Until ${dateFormat.format(selected.toLocal())} ${timeFormat.format(selected.toLocal())}';
      } else {
        return 'Time Until ${dateFormat.format(selected.toLocal())}';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var state = context.watch<ApplicationState>();

    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.date_range),
        title: Text(
          _generateTitle(state.selected, state.showTime),
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
