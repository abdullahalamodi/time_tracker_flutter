import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/models/entry.dart';
import 'package:time_tracker_flutter_course/app/models/job.dart';
import 'package:time_tracker_flutter_course/common_widgets/format.dart';

class EntryListItem extends StatelessWidget {
  const EntryListItem({
    Key key,
    @required this.entry,
    @required this.job,
    @required this.onTap,
  }) : super(key: key);
  final Entry entry;
  final Job job;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Row(
          children: <Widget>[
            Expanded(child: _buildContent(context)),
            SizedBox(width: 10),
            Icon(Icons.chevron_right_sharp),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final dayOfWeek = Format.dayOfWeek(entry.start);
    final date = Format.date(entry.start);
    final startTime = Format.time(entry.start, context);
    final endTime = Format.time(entry.end, context);
    final hours = Format.hours(entry.durationInHours);

    final payInDouble = job.rateperHour * entry.durationInHours;
    final pay = Format.currency(payInDouble);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: [
            Text(dayOfWeek, style: TextStyle(color: Colors.grey, fontSize: 18)),
            SizedBox(width: 15),
            Text(date),
            if (payInDouble > 0.0) ...<Widget>[
              Spacer(),
              Text(
                pay,
                style: TextStyle(color: Colors.green[700]),
              ),
            ]
          ],
        ),
        SizedBox(height: 5),
        Row(
          children: <Widget>[
            Text(
              '$startTime - $endTime',
              style: TextStyle(fontSize: 12, color: Colors.grey[700]),
            ),
            Spacer(),
            Text(hours),
          ],
        ),
        SizedBox(height: 5),
        Text(
          entry.comment,
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
