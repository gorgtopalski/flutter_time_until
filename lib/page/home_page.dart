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
          return HomePageCard.fromDataEntry(box.getAt(index), index);
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
          valueListenable: Hive.box<DateEntry>('dates').listenable(),
          builder: (context, Box box, widget) {
            if (box.length == 0) {
              return _showEmptyMessage(context);
            } else {
              return _buildListOfDates(context, box);
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
  late final String title;
  late final String targetDateString;
  late final String remaingTimeString;
  late final IconData icon;
  late final int index;
  late final DateTime? date;

  HomePageCard(
      {required this.title,
      required this.targetDateString,
      required this.remaingTimeString,
      this.icon = Icons.star});

  HomePageCard.fromDataEntry(DateEntry entry, int index) {
    this.date = entry.date;
    this.title = entry.description ?? '';
    this.targetDateString = DateFormat.yMd().format(entry.date);
    this.remaingTimeString = entry.timeRemaining.inDays.toString() + ' days';
    this.icon = entry.icon ?? Icons.star;
    this.index = index;
  }

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
                      builder: (context) =>
                          TimePage(this.date!, title: this.title)));
            },
            contentPadding: const EdgeInsets.all(8),
            leading: Icon(icon),
            title: Text(title),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(targetDateString),
                Text(remaingTimeString),
              ],
            ),
          ),
        ),
        actions: <Widget>[
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
                    builder: (context) => AddCountdownPage(
                      date!,
                      description: title,
                    ),
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

  _showSnackBar(String s) {
    print(s);
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

class AddCountdownPage extends StatefulWidget {
  final DateTime selectedDate;
  final String description;

  AddCountdownPage(this.selectedDate, {this.description = ''});

  @override
  _AddCountdownPageState createState() => _AddCountdownPageState();
}

class _AddCountdownPageState extends State<AddCountdownPage> {
  final _formKey = GlobalKey<FormState>();
  TimeOfDay? time;
  DateTime? date;
  DateTime? widgetDate;
  bool showTime = false;

  String description = '';

  void _saveNewTimer() {
    var entry = DateEntry(description, widget.selectedDate);
    Hive.box<DateEntry>('dates').add(entry);
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();

    date = widget.selectedDate;
    widgetDate = date;
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
                SelectDateTime.selectDate(context,
                        initialDate: this.widgetDate!)
                    .then((value) {
                  if (value != null) {
                    setState(() {
                      this.widgetDate = value;
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
                    .then((value) => this.setState(() {
                          if (value != null) {
                            time = value;
                            showTime = true;
                            widgetDate = date!.add(Duration(
                                hours: time!.hour, minutes: time!.minute));
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
                          ? DateFormat.yMd().add_Hm().format(widgetDate!)
                          : DateFormat.yMd().format(widgetDate!),
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
                        initialValue: widget.description,
                        validator: (value) => value,
                        onChanged: (value) => description = value,
                      ),
                    ),
                    SizedBox(height: 24),
                    SizedBox(
                      height: 50,
                      width: 125,
                      child: ElevatedButton.icon(
                        onPressed: _saveNewTimer,
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
