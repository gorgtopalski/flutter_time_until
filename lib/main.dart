import 'package:flutter/material.dart';
import 'package:flutter_time_until/state/application_preferences.dart';
import 'package:flutter_time_until/state/application_timer.dart';
import 'package:flutter_time_until/time/time_until.dart';
import 'package:flutter_time_until/wigets/page_widget.dart';
import 'package:flutter_time_until/wigets/popup_menu.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart';
import 'package:provider/provider.dart';

import 'common/theme.dart';

void main() {
  findSystemLocale()
      .then((value) => {
            Intl.defaultLocale = value,
            initializeDateFormatting(),
          })
      .whenComplete(() => runApp(MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) => ApplicationTimer(),
                lazy: false,
              ),
              ChangeNotifierProvider(
                create: (_) => ApplicationPreferences(),
                lazy: false,
              ),
            ],
            child: TimeUntilApplication(),
          )));
}

class TimeUntilApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (!context.watch<ApplicationTimer>().isLoaded &&
        !context.watch<ApplicationPreferences>().isLoaded) {
      return Container(
          child: Center(
              child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: CircularProgressIndicator(
          value: null,
        ),
      )));
    } else {
      var isDark = context.watch<ApplicationPreferences>().darkTheme;
      var theme = ApplicationTheme.themeData(isDark);

      return MaterialApp(
        title: 'Time Until',
        theme: theme,
        home: TimePage(),
        //home: HomePage(),
        debugShowCheckedModeBanner: false,
      );
    }
  }
}

class HomePage extends StatelessWidget {
  final entries = <Widget>[
    Card(
        margin: EdgeInsets.all(4),
        child: ListTile(
            contentPadding: EdgeInsets.all(8),
            leading: Icon(Icons.hotel),
            title: Text('Vacation'),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(new DateFormat.yMd()
                    .format(DateTime.now().add(Duration(days: 5500)).toLocal())
                    .toString()),
                Text(DateTime.now()
                        .add(Duration(days: 5500))
                        .difference(DateTime.now())
                        .inDays
                        .toString() +
                    ' days remaing')
              ],
            ))),
    Card(
        margin: EdgeInsets.all(4),
        child: ListTile(
            onTap: () {},
            contentPadding: EdgeInsets.all(8),
            leading: Icon(Icons.hotel),
            title: Text('Vacation'),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(new DateFormat.yMd()
                    .format(DateTime.now().add(Duration(days: 5500)).toLocal())
                    .toString()),
                Text(DateTime.now()
                        .add(Duration(days: 5500))
                        .difference(DateTime.now())
                        .inDays
                        .toString() +
                    ' days remaing')
              ],
            ))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.date_range),
        title: Text('Time Until'),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return entries[index];
        },
        itemCount: entries.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        tooltip: 'Add a date countdown',
      ),
    );
  }
}

class TimePage extends StatelessWidget {
  final String title = 'Time Until';
  final dateFormat = new DateFormat.yMd();
  final timeFormat = new DateFormat.Hm();

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

  //Shows the DatePicker widget and updates the state if one is selected
  void _showDatePicker(
      BuildContext context, ApplicationTimer timer, bool showTime) {
    var now = DateTime.now();

    showDatePicker(
            context: context,
            initialDate: now,
            firstDate: now,
            lastDate: DateTime(now.year + 50))
        .then((selectedDate) {
      if (showTime) {
        showTimePicker(context: context, initialTime: TimeOfDay.now()).then(
            (selectedTime) =>
                timer.setSelectedDate(selectedDate, selectedTime));
      } else {
        timer.setSelectedDate(selectedDate);
      }
    });
  }

  String _generateTitle(bool isTimeSelected, DateTime selected,
      [bool displayTime = false]) {
    if (!isTimeSelected)
      return title;
    else {
      if (displayTime) {
        return 'Time Until ${dateFormat.format(selected.toLocal())} ${timeFormat.format(selected.toLocal())}';
      } else {
        return 'Time Until ${dateFormat.format(selected.toLocal())}';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var state = context.watch<ApplicationPreferences>();
    var timer = context.watch<ApplicationTimer>();
    var calc = TimeUntil(state.now, timer.selected, state.precision);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.date_range),
          title: Text(
            _generateTitle(timer.isSelected, timer.selected, state.isShowTime),
            textAlign: TextAlign.left,
          ),
          bottom: timer.isSelected
              ? TabBar(
                  tabs: tabs,
                  indicatorColor: Theme.of(context).accentColor,
                )
              : null,
          actions: [
            ApplicationPopUpMenu(),
          ],
        ),
        body: Center(
            child: context.watch<ApplicationTimer>().isSelected
                ? Container(
                    margin: const EdgeInsets.all(4),
                    child: TabBarView(
                      children: [
                        DisplayEntries(calc.common),
                        DisplayEntries(calc.ancient),
                        DisplayEntries(calc.scientific),
                      ],
                    ),
                  )
                : Text(
                    'Please select a date',
                    style: Theme.of(context).textTheme.headline4,
                  )),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {_showDatePicker(context, timer, state.isShowTime)},
          tooltip: 'Select a date',
          child: Icon(Icons.date_range),
        ),
      ),
    );
  }
}
