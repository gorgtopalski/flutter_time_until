import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../application_state.dart';
import '../time_calculator.dart';

class TabBuilder extends State<StatefulWidget>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  TabBuilder() {
    _controller = TabController(vsync: this, length: 3, initialIndex: 0);
  }

  TabBar getTabBar(BuildContext context) {
    return TabBar(
      controller: _controller,
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
    var calc = TimeCalculator(state.now, state.selected, state.precision);

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
        return Entry(entries[key], key);
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
