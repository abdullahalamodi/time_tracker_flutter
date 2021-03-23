class Entry {
  final String id;
  final DateTime start;
  final DateTime end;
  final String comment;
  final String jobId;

  Entry({
    this.id,
    this.start,
    this.end,
    this.comment,
    this.jobId,
  });

  double get durationInHours => end.difference(start).inHours.toDouble();

  Map<String, dynamic> toMap() {
    return {
      'start': start.millisecondsSinceEpoch,
      'end': end.millisecondsSinceEpoch,
      'comment': comment,
      'jobId': jobId,
    };
  }

  factory Entry.fromMap(Map<String, dynamic> map, String docId) {
    return Entry(
      id: docId,
      start: DateTime.fromMillisecondsSinceEpoch(map['start']),
      end: DateTime.fromMillisecondsSinceEpoch(map['end']),
      comment: map['comment'],
      jobId: map['jobId'],
    );
  }

  Entry copyWith({
    String id,
    DateTime start,
    DateTime end,
    String comment,
    String jobId,
  }) {
    return Entry(
      id: id ?? this.id ?? _entityIdGenerator,
      start: start ?? this.start ?? DateTime.now(),
      end: end ?? this.end ?? DateTime.now(),
      comment: comment ?? this.comment ?? '',
      jobId: jobId ?? this.jobId,
    );
  }

  static String get _entityIdGenerator => DateTime.now().toIso8601String();
}
