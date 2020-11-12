import 'package:flutter/material.dart';
import 'package:flutter_time_until/state/application_preferences.dart';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';

enum PopUpCommands { dark, increment, decrement, time, update }

class ApplicationPopUpMenu extends StatelessWidget {
  void _precisionChangeNotification(BuildContext context) {
    var state = context.read<ApplicationPreferences>();
    Scaffold.of(context).showSnackBar(SnackBar(
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
              state.changeTheme(!state.darkTheme);
              break;
            case PopUpCommands.increment:
              if (state.precision < 20) {
                state.changePrecision(state.precision + 1);
                _precisionChangeNotification(context);
              }
              break;
            case PopUpCommands.decrement:
              if (state.precision > 1) {
                state.changePrecision(state.precision - 1);
                _precisionChangeNotification(context);
              }
              break;
            case PopUpCommands.time:
              state.showTimeSelection(!state.showTime);
              break;
            case PopUpCommands.update:
              state.toggleTimerUpdate();
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
            checked: state.showTime,
          ),
          PopupMenuDivider(),
          CheckedPopupMenuItem<PopUpCommands>(
            value: PopUpCommands.update,
            child: const Text('Update Timer'),
            checked: state.updateTimer,
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
