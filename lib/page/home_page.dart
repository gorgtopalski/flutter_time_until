import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_time_until/data/data_entry.dart';
import 'package:flutter_time_until/page/time_page.dart';
import 'package:flutter_time_until/time/time_selector.dart';
import 'package:flutter_time_until/wigets/popup_menu.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatelessWidget {
  final values = Hive.box<DateEntry>('dates').listenable();

  void _addNewDate(BuildContext context) {
    SelectDateTime.selectDate(context).then((selectedDate) {
      if (selectedDate != null) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddCountdownPage(selectedDate),
            ));
      }
    });
  }

  void _previewDate(BuildContext context) {
    SelectDateTime.selectDate(context).then((selectedDate) {
      if (selectedDate != null) {
        var format = DateFormat.yMd();

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TimePage(
                      selectedDate,
                      title: 'Time Until ' + format.format(selectedDate),
                      showSaveButton: true,
                    )));
      }
    });
  }

  ListView _buildListOfDates(BuildContext context, Box box) {
    return ListView.builder(
        itemCount: box.length,
        itemBuilder: (BuildContext context, int index) {
          return HomePageCard(box.getAt(index), index);
        });
  }

  Widget _showEmptyMessage(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.pending_actions,
            size: 128,
            color: Colors.white24,
          ),
          SizedBox(
            height: 12,
          ),
          Text('Please add a date',
              style: Theme.of(context).textTheme.headline4),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.date_range),
        title: Text('Time Until'),
        actions: [
          Tooltip(
            message: 'Preview a date',
            child: IconButton(
              icon: Icon(Icons.published_with_changes),
              onPressed: () {
                _previewDate(context);
              },
            ),
          ),
          MainPopUpMenu(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ValueListenableBuilder(
          valueListenable: values,
          builder: (context, Box box, widget) {
            try {
              if (box.length == 0) {
                return _showEmptyMessage(context);
              } else {
                return _buildListOfDates(context, box);
              }
            } catch (ex) {
              return _showEmptyMessage(context);
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Date'),
        onPressed: () => _addNewDate(context),
        icon: Icon(Icons.add),
        //child: Icon(Icons.add),
        tooltip: 'Add a new countdown',
      ),
    );
  }
}

class HomePageCard extends StatelessWidget {
  final IconData icon;
  final int index;
  final DateEntry entry;

  HomePageCard(this.entry, this.index, {this.icon = Icons.star});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        child: Container(
          //color: Colors.white,
          child: ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TimePage(
                            entry.date,
                            title: entry.description ?? '',
                          )));
            },
            contentPadding: const EdgeInsets.all(8),
            leading: Icon(icon),
            title: Text(entry.description ?? ''),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(this.entry.timeSelectedString),
                Text(this.entry.timeRemainingString),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          //TODO: Implement share functionality
          /*
          IconSlideAction(
            caption: 'Archive',
            color: Colors.blue,
            icon: Icons.archive,
            onTap: () => _showSnackBar('Archive'),
          ),
          IconSlideAction(
            caption: 'Share',
            color: Colors.indigo,
            icon: Icons.share,
            onTap: () => _showSnackBar('Share'),
          ),
          */
        ],
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: 'Edit',
            color: Colors.green,
            icon: Icons.edit,
            onTap: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditCountdownPage(entry, index),
                  ));
            },
          ),
          IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () async {
              if (await showAlertDialog(context) == true) {
                await Hive.box<DateEntry>('dates').deleteAt(this.index);
              }
            },
          ),
        ],
      ),
    );
  }

  Future<bool?> showAlertDialog(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Row(
        children: [
          Icon(Icons.delete),
          Text('Delete dialog'),
        ],
      ),
      content: Text("You are about to delete the entry"),
      actions: [
        ElevatedButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.pop(context, false);
            }),
        TextButton.icon(
            icon: Icon(Icons.delete),
            label: Text("Delete"),
            onPressed: () {
              Navigator.pop(context, true);
            }),
      ],
    );

    // show the dialog
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class AddCountdownPage extends _CountdownPage {
  AddCountdownPage(DateTime date, {String description = ''})
      : super(DateEntry(description, date), -1);

  @override
  void saveCountdownTimer(BuildContext context, DateEntry entry, int index) {
    Hive.box<DateEntry>('dates').add(entry);
    Navigator.of(context).pop();
  }
}

class EditCountdownPage extends _CountdownPage {
  EditCountdownPage(DateEntry entry, int index) : super(entry, index);

  @override
  void saveCountdownTimer(BuildContext context, DateEntry entry, int index) {
    print('update');
    Hive.box<DateEntry>('dates').putAt(index, entry);
    Navigator.of(context).pop();
  }
}

abstract class _CountdownPage extends StatefulWidget {
  late final DateEntry entry;
  late final int index;

  _CountdownPage(this.entry, this.index);

  void saveCountdownTimer(BuildContext context, DateEntry entry, int index);

  @override
  _CountdownPageState createState() => _CountdownPageState();
}

class _CountdownPageState extends State<_CountdownPage> {
  final _formKey = GlobalKey<FormState>();
  bool showTime = false;

  late DateTime date;
  late String description;

  @override
  void initState() {
    super.initState();
    date = widget.entry.date;
    description = widget.entry.description ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new date'),
        actions: [
          Tooltip(
            message: 'Change date',
            child: IconButton(
              onPressed: () {
                SelectDateTime.selectDate(context, initialDate: date)
                    .then((value) {
                  if (value != null) {
                    setState(() {
                      date = value;
                    });
                  }
                });
              },
              icon: Icon(
                Icons.date_range,
              ),
            ),
          ),
          Tooltip(
            message: 'Add time of day',
            child: IconButton(
              onPressed: () {
                showTimePicker(context: context, initialTime: TimeOfDay.now())
                    .then((time) => this.setState(() {
                          if (time != null) {
                            showTime = true;
                            date = date.add(Duration(
                              hours: time.hour,
                              minutes: time.minute,
                            ));
                          }
                        }));
              },
              icon: Icon(
                Icons.timer,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: Center(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //Display selected date
                    Text(
                      showTime
                          ? DateFormat.yMd().add_Hm().format(date)
                          : DateFormat.yMd().format(date),
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    SizedBox(height: 12),

                    //Description input form field
                    SizedBox(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Description",
                          border: OutlineInputBorder(),
                        ),
                        initialValue: description,
                        onChanged: (value) => description = value,
                      ),
                    ),
                    SizedBox(height: 24),
                    SizedBox(
                      height: 50,
                      width: 125,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          widget.entry.date = date;
                          widget.entry.description = description;
                          widget.saveCountdownTimer(
                              context, this.widget.entry, this.widget.index);
                        },
                        label: Text('Save'),
                        icon: Icon(
                          Icons.save,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
