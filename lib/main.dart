import 'package:flutter/material.dart';
import 'package:flutter_time_until/page/home_page.dart';
import 'package:flutter_time_until/state/application_preferences.dart';
import 'package:hive/hive.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'common/theme.dart';
import 'data/data_entry.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(DateEntryAdapter());
  await Hive.openBox('prefs');
  await Hive.openBox<DateEntry>('dates');

  findSystemLocale()
      .then((value) => {
            Intl.defaultLocale = value,
            initializeDateFormatting(),
          })
      .whenComplete(
        () => runApp(ChangeNotifierProvider(
          create: (_) => ApplicationPreferences(),
          lazy: false,
          child: TimeUntilApplication(),
        )),
      );
}

class TimeUntilApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = ApplicationTheme.themeData(
        context.watch<ApplicationPreferences>().darkTheme);

    return MaterialApp(
      title: 'Time Until',
      supportedLocales: [
        Locale('es', 'ES'),
        Locale('en', 'US'),
      ],
      theme: theme,
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
