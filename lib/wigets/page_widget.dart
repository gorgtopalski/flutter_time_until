import 'package:flutter/material.dart';
import 'package:flutter_time_until/time/unit_description.dart';

class DisplayEntries extends StatelessWidget {
  final Map<String, String?> entries;

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
  final String? title;
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
          title: Text(widget.title!),
          subtitle: tapped
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.subtitle,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      UnitOfTimeDescription.getDescription(widget.subtitle),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                )
              : Text(widget.subtitle)),
    );
  }
}
