import 'dart:convert';

class Job {
  final String name;
  final int rateperHour;

  Job({
    this.name: '',
    this.rateperHour: 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'rateperHour': rateperHour,
    };
  }

  factory Job.fromMap(Map<String, dynamic> map) {
    return map == null
        ? null
        : Job(
            name: map['name'] ?? '',
            rateperHour: map['rateperHour'] ?? 0,
          );
  }

  String toJson() => json.encode(toMap());

  factory Job.fromJson(String source) => Job.fromMap(json.decode(source));
}
