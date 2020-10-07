import 'package:flutter/material.dart';

import '../time_calculator.dart';

class PageBuilder extends StatelessWidget {
  final controller = PageController(initialPage: 0);

  final TimeCalculator _calc;

  PageBuilder(this._calc);

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller,
      children: [
        PageWidget(
          title: 'Common',
          titleIcon: Icons.query_builder,
          entries: _calc.common,
        ),
        PageWidget(
          title: 'Ancient',
          titleIcon: Icons.public,
          entries: _calc.ancient,
        ),
        PageWidget(
          title: 'Scientifc',
          titleIcon: Icons.biotech,
          entries: _calc.scientific,
        )
      ],
    );
  }
}

class PageWidget extends StatelessWidget {
  final String title;
  final IconData titleIcon;
  final Map<String, String> entries;

  PageWidget({this.entries, this.title, this.titleIcon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          PageTitle(title: title, icon: titleIcon),
          SizedBox(
            height: 25,
          ),
          DisplayEntries(entries)
        ],
      )),
    );
  }
}

class PageTitle extends StatelessWidget {
  final String title;
  final IconData icon;

  PageTitle({this.title, this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline1,
        ),
        SizedBox(
          width: 20,
        ),
        Icon(icon,
            color: Theme.of(context).textTheme.headline1.color,
            size: Theme.of(context).textTheme.headline1.fontSize)
      ],
    );
  }
}

class DisplayEntries extends StatelessWidget {
  final Map<String, String> entries;

  DisplayEntries(this.entries);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: entries.keys
          .map((key) => Text(
                entries[key] + ' ' + key,
                style: Theme.of(context).textTheme.headline2,
              ))
          .toList(),
    );
  }
}
