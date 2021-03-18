import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/models/job.dart';

class JobListItem extends StatelessWidget {
  const JobListItem({
    Key key,
    @required this.job,
    @required this.onTap,
  }) : super(key: key);
  final Job job;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(8.0),
      trailing: Icon(Icons.chevron_right_sharp),
      title: Text(job.name),
      onTap: onTap,
    );
  }
}
