import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/job_entries/entries_viewmodel.dart';
import 'package:time_tracker_flutter_course/common_widgets/date_time_picker.dart';
import 'package:time_tracker_flutter_course/common_widgets/format.dart';
import 'package:time_tracker_flutter_course/common_widgets/show_exception_alert_dialog.dart';

class AddEntryPage extends StatefulWidget {
  const AddEntryPage({Key key, @required this.viewmodel}) : super(key: key);
  final EntriesViewModel viewmodel;

  static Future<void> create(
      BuildContext context, EntriesViewModel viewmodel) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddEntryPage(viewmodel: viewmodel),
      ),
    );
  }

  @override
  _AddEntryPageState createState() => _AddEntryPageState();
}

class _AddEntryPageState extends State<AddEntryPage> {
  _submetEntry(BuildContext context) async {
    try {
      await widget.viewmodel.addEntry();
      Navigator.pop(context);
    } on Exception catch (e) {
      showExceptionAlertDialog(
        context,
        title: "operation field",
        exception: e,
      );
    }
  }

  Widget _buildDuration() {
    final durationFormatted =
        Format.hours(widget.viewmodel.entry.durationInHours);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Text(
          'Duration: $durationFormatted',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildComment() {
    return TextField(
      keyboardType: TextInputType.text,
      maxLength: 50,
      controller: TextEditingController(text: widget.viewmodel.entry.comment),
      decoration: InputDecoration(
        labelText: 'Comment',
        labelStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
      ),
      style: TextStyle(fontSize: 20.0, color: Colors.black),
      maxLines: null,
      onChanged: (comment) {
        widget.viewmodel.updateWith(
            entry: widget.viewmodel.entry.copyWith(comment: comment),
            notify: false);
      },
      onSubmitted: (value) => _submetEntry(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      children: <Widget>[
        DateTimePicker(
            labelText: 'start date',
            initValue: widget.viewmodel.entry.start ?? DateTime.now(),
            onPicked: (dateTime) {
              widget.viewmodel.updateWith(
                  entry: widget.viewmodel.entry.copyWith(start: dateTime),
                  notify: false);
              setState(() {});
            }),
        SizedBox(height: 10),
        DateTimePicker(
            labelText: 'end date',
            initValue: widget.viewmodel.entry.end ?? DateTime.now(),
            onPicked: (dateTime) {
              widget.viewmodel.updateWith(
                  entry: widget.viewmodel.entry.copyWith(end: dateTime),
                  notify: false);
              setState(() {});
            }),
        SizedBox(height: 10),
        _buildDuration(),
        SizedBox(height: 10),
        _buildComment(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Entry"),
        actions: [
          TextButton(
            onPressed: () => _submetEntry(context),
            child: Text(
              "create",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildContent(context),
            ),
          ),
        ),
      ),
    );
  }
}
