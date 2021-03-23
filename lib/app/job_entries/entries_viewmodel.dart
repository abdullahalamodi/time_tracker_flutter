import 'package:flutter/cupertino.dart';
import 'package:time_tracker_flutter_course/app/jobs/jobs_viewmodel.dart';
import 'package:time_tracker_flutter_course/app/models/entry.dart';
import 'package:time_tracker_flutter_course/app/models/job.dart';

import 'package:time_tracker_flutter_course/services/firestore_database.dart';

class EntriesViewModel extends ChangeNotifier {
  EntriesViewModel({
    @required this.jobsViewmodel,
    @required this.database,
  });
  final JobsViewmodel jobsViewmodel;
  final Database database;
  bool _isLoading = false;
  Entry _entry;

  Stream<List<Entry>> entriesStream() => database.entriesStream(job);

  Future<void> addEntry() async {
    updateWith(isLoading: true);
    _entry = entry.copyWith(jobId: job.id);
    await database.setEntry(_entry);
    updateWith(isLoading: false);
  }

  void updateWith({
    bool isLoading,
    Entry entry,
    bool notify = true,
  }) {
    this._isLoading = isLoading ?? this.isLoading;
    this._entry = entry ?? this.entry;
    if (notify) notifyListeners();
  }

  //getters
  bool get isLoading => _isLoading;
  Job get job => jobsViewmodel.job;
  Entry get entry => _entry ?? Entry().copyWith();
}
