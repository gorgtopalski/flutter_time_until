import 'package:flutter/material.dart';
import 'package:flutter_time_until/state/application_preferences.dart';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';

enum PopUpCommands {
  dark,
  increment,
  decrement,
  update,
  about,
}

class MainPopUpMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var prefs = context.watch<ApplicationPreferences>();
    return Builder(
      builder: (context) => PopupMenuButton<PopUpCommands>(
        onSelected: (PopUpCommands result) {
          if (result == PopUpCommands.dark) {
            prefs.toggleTheme();
          }

          if (result == PopUpCommands.update) {
            prefs.toggleTimerUpdate();
          }

          if (result == PopUpCommands.about) {
            showAboutDialog(context: context);
          }
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<PopUpCommands>>[
          CheckedPopupMenuItem<PopUpCommands>(
            value: PopUpCommands.update,
            child: const Text('Update Timer'),
            checked: prefs.isTimerUpdate,
          ),
          PopupMenuDivider(),
          CheckedPopupMenuItem<PopUpCommands>(
            value: PopUpCommands.dark,
            child: const Text('Dark Mode'),
            checked: prefs.darkTheme,
          ),
          PopupMenuDivider(),
          PopupMenuItem<PopUpCommands>(
            value: PopUpCommands.about,
            child: Text('About'),
          ),
        ],
      ),
    );
  }
}

class ApplicationPopUpMenu extends StatelessWidget {
  void _precisionChangeNotification(BuildContext context) {
    var state = context.read<ApplicationPreferences>();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Value precision is set to ${state.precision}'),
      duration: Duration(seconds: 1),
    ));
  }

  @override
  Widget build(BuildContext context) {
    var state = context.watch<ApplicationPreferences>();

    return Builder(
      builder: (context) => PopupMenuButton<PopUpCommands>(
        onSelected: (PopUpCommands result) {
          switch (result) {
            case PopUpCommands.dark:
              state.toggleTheme();
              break;
            case PopUpCommands.increment:
              state.incrementPrecision();
              _precisionChangeNotification(context);
              break;
            case PopUpCommands.decrement:
              state.decrementPrecision();
              _precisionChangeNotification(context);
              break;

            case PopUpCommands.update:
              state.toggleTimerUpdate();
              break;
            case PopUpCommands.about:
              //Not used here
              break;
          }
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<PopUpCommands>>[
          PopupMenuItem<PopUpCommands>(
            enabled: state.precision < 20,
            value: PopUpCommands.increment,
            child: ListTile(
              leading: Icon(Icons.add),
              title: Text('Add precision'),
            ),
          ),
          PopupMenuItem<PopUpCommands>(
            enabled: state.precision > 1,
            value: PopUpCommands.decrement,
            child: ListTile(
              leading: Icon(Icons.remove),
              title: Text('Remove precision'),
            ),
          ),
          PopupMenuDivider(),
          CheckedPopupMenuItem<PopUpCommands>(
            value: PopUpCommands.update,
            child: const Text('Update Timer'),
            checked: state.isTimerUpdate,
          ),
          PopupMenuDivider(),
          CheckedPopupMenuItem<PopUpCommands>(
            value: PopUpCommands.dark,
            child: const Text('Dark Mode'),
            checked: state.darkTheme,
          ),
        ],
      ),
    );
  }
}
