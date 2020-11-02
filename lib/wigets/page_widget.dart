import 'package:flutter/material.dart';
import 'package:flutter_time_until/time/time_until.dart';
import 'package:flutter_time_until/time/unit_description.dart';
import 'package:provider/provider.dart';

import '../application_state.dart';

class TabBuilder extends State<StatefulWidget>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  TabBuilder() {
    _controller = TabController(vsync: this, length: 3, initialIndex: 0);
  }

  TabBar getTabBar(BuildContext context) {
    return TabBar(
      controller: _controller,
      indicatorColor: Theme.of(context).colorScheme.primary,
      tabs: [
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
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var state = context.watch<ApplicationState>();
    var calc = TimeUntil(state.now, state.selected, state.precision);

    return Container(
      margin: const EdgeInsets.all(4),
      child: TabBarView(controller: _controller, children: [
        DisplayEntries(calc.common),
        DisplayEntries(calc.ancient),
        DisplayEntries(calc.scientific),
      ]),
    );
  }
}

class DisplayEntries extends StatelessWidget {
  final Map<String, String> entries;

  DisplayEntries(this.entries);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: entries.keys.length,
      itemBuilder: (BuildContext context, int index) {
        var key = entries.keys.elementAt(index);
        return StatufulEntry(entries[key], key);
      },
    );
  }
}

class Entry extends StatelessWidget {
  final String title;
  final String subtitle;

  Entry(this.title, this.subtitle);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.arrow_right),
        contentPadding: EdgeInsets.all(8),
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }
}

class StatufulEntry extends StatefulWidget {
  final String title;
  final String subtitle;

  StatufulEntry(this.title, this.subtitle);

  @override
  _StatufulEntryState createState() => _StatufulEntryState();
}

class _StatufulEntryState extends State<StatufulEntry> {
  var icon = Icons.arrow_right;
  bool tapped = false;

  void _onTap() {
    setState(() {
      tapped = !tapped;
      tapped ? icon = Icons.arrow_drop_down : icon = Icons.arrow_right;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          onTap: _onTap,
          selected: tapped,
          leading: Icon(icon),
          contentPadding: EdgeInsets.all(8),
          title: Text(widget.title),
          //onLongPress: () => {showDialog(context: context)},
          subtitle: tapped
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(widget.subtitle),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      UnitOfTimeDescription.getDescription(widget.subtitle),
                    ),
                  ],
                )
              : Text(widget.subtitle)),
    );
  }
}
