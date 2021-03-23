import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/common_widgets/format.dart';
import 'package:time_tracker_flutter_course/common_widgets/input_dropdown.dart';

class DateTimePicker extends StatelessWidget {
  const DateTimePicker({
    Key key,
    this.labelText,
    @required this.initValue,
    @required this.onPicked,
  })  : assert(initValue != null),
        super(key: key);
  final String labelText;
  final DateTime initValue;
  final ValueChanged<DateTime> onPicked;

  Future<void> _selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initValue,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 20)),
    );
    if (pickedDate != null && pickedDate != initValue) {
      _selectTime(context, pickedDate);
    }
  }

  Future<void> _selectTime(BuildContext context, DateTime pickedDate) async {
    TimeOfDay _selectedDateTime = TimeOfDay.fromDateTime(initValue);
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedDateTime,
    );
    final pickedDatetime = DateTime(pickedDate.year, pickedDate.month,
        pickedDate.day, pickedTime.hour, pickedTime.minute);
    if (pickedTime != null) {
      onPicked(pickedDatetime);
    }
  }

  @override
  Widget build(BuildContext context) {
    final valueStyle = Theme.of(context).textTheme.headline6;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: InputDropdown(
            labelText: labelText,
            valueText: Format.dateTime(initValue),
            valueStyle: valueStyle,
            onPressed: () => _selectDate(context),
          ),
        ),
      ],
    );
  }
}
