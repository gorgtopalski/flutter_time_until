import 'package:flutter/material.dart';
import 'package:flutter_time_until/state/application_preferences.dart';
import 'package:flutter_time_until/state/application_timer.dart';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';

enum PopUpCommands { dark, increment, decrement, time, update, reset }

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
            case PopUpCommands.time:
              state.toogleTimeSelection();
              break;
            case PopUpCommands.update:
              state.toggleTimerUpdate();
              break;
            case PopUpCommands.reset:
              showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            title: Text('Reset Timer'),
                            content: Text(
                                'You are about to reset the application timer.'),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: Text('Ok')),
                              ElevatedButton(
                                  onPressed: () =>
                                      Navigator.pop(context, false),
                                  child: Text('Cancel')),
                            ],
                          ),
                      barrierDismissible: true)
                  .then((value) {
                if (value == true) {
                  context.read<ApplicationTimer>().reset();
                }
              });
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
            value: PopUpCommands.time,
            child: const Text('Allow time selection'),
            checked: state.isShowTime,
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
          PopupMenuDivider(),
          PopupMenuItem<PopUpCommands>(
            value: PopUpCommands.reset,
            child: ListTile(
              leading: Icon(Icons.timer),
              title: Text('Reset Timer'),
            ),
          ),
        ],
      ),
    );
  }
}
