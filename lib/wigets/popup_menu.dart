import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';

import '../application_state.dart';

enum PopUpCommands { dark, increment, decrement, time }

class ApplicationPopUpMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var state = context.watch<ApplicationState>();
    return Builder(
      builder: (context) => PopupMenuButton<PopUpCommands>(
        onSelected: (PopUpCommands result) {
          switch (result) {
            case PopUpCommands.dark:
              state.changeTheme(!state.darkTheme);
              break;
            case PopUpCommands.increment:
              if (state.precision < 20) {
                state.updatePrecission(state.precision + 1);
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('Value precision is set to ${state.precision}'),
                  duration: Duration(seconds: 1),
                ));
              }
              break;
            case PopUpCommands.decrement:
              if (state.precision > 1) {
                state.updatePrecission(state.precision - 1);
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('Value precision is set to ${state.precision}'),
                  duration: Duration(seconds: 1),
                ));
              }
              break;
            case PopUpCommands.time:
              state.showTimePicker(!state.showTime);
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
    );
  }
}
