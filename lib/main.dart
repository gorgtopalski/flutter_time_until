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
  await StorageService._instance.start();

  /*
  await Hive.initFlutter();
  Hive.registerAdapter(DateEntryAdapter());
  await Hive.openBox('prefs');
  await Hive.openBox<DateEntry>('dates');
*/
  findSystemLocale()
      .then((value) => {
            Intl.defaultLocale = value,
            initializeDateFormatting(),
          })
      .whenComplete(
        () => runApp(ChangeNotifierProvider(
          create: (_) => ApplicationPreferences(),
          lazy: true,
          child: TimeUntilApplication(),
        )),
      );
}

class StorageService {
  static final StorageService _instance = StorageService._internal();
  Box? prefs;
  Box? db;

  StorageService._internal() {
    Hive.registerAdapter(DateEntryAdapter());
  }

  factory StorageService() {
    return _instance;
  }

  Future<void> start() async {
    prefs = await Hive.openBox('prefs');
    db = await Hive.openBox<DateEntry>('dates');
  }

  Future<void> stop() async {
    if (prefs != null) {
      await prefs!.compact();
      await prefs!.close();
    }

    if (db != null) {
      await db!.compact();
      await db!.close();
    }
  }
}

class TimeUntilApplication extends StatelessWidget {
  final StorageService service = StorageService._instance;

  @override
  Widget build(BuildContext context) {
    var theme = ApplicationTheme.themeData(
        context.watch<ApplicationPreferences>().darkTheme);

    return LifecycleReactor(
      attachAction: () async {
        await service.start();
      },
      detachAction: () async {
        await service.stop();
      },
      child: MaterialApp(
        title: 'Time Until',
        supportedLocales: [
          //Locale('es', 'ES'),
          Locale('en', 'US'),
        ],
        theme: theme,
        home: HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class LifecycleReactor extends StatefulWidget {
  final Widget child;
  final Function detachAction;
  final Function attachAction;

  const LifecycleReactor(
      {Key? key,
      required this.child,
      required this.detachAction,
      required this.attachAction})
      : super(key: key);

  @override
  _LifecycleReactorState createState() => _LifecycleReactorState();
}

class _LifecycleReactorState extends State<LifecycleReactor>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        widget.detachAction();
        break;
      case AppLifecycleState.resumed:
        widget.attachAction();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
