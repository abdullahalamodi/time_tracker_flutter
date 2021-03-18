import 'dart:convert';

import 'package:time_tracker_flutter_course/app/utils/validators.dart';

class Job with JobValidators {
  String id = Job._jobIdGenerator;
  String name;
  int rateperHour;

  Job({
    this.id,
    this.name: '',
    this.rateperHour: 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'rateperHour': rateperHour,
    };
  }

  factory Job.fromMap(Map<String, dynamic> map, {String id}) {
    return map == null
        ? null
        : Job(
            id: id ?? null,
            name: map['name'] ?? '',
            rateperHour: map['rateperHour'] ?? 0,
          );
  }

  bool get validName => nameValidator.isValid(this.name);
  bool get validRatePerHour => ratePerHourValidator.isValid(this.rateperHour);

  String toJson() => json.encode(toMap());

  factory Job.fromJson(String source) => Job.fromMap(json.decode(source));

  Job updateWith({
    String id,
    String name,
    int ratePerHour,
  }) {
    this.id = id ?? this.id;
    this.name = name ?? this.name;
    this.rateperHour = ratePerHour ?? this.rateperHour;
    return this;
  }

  static String get _jobIdGenerator => DateTime.now().toIso8601String();
}
