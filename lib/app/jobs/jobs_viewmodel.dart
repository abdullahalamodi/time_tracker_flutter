import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:time_tracker_flutter_course/app/models/job.dart';
import 'package:time_tracker_flutter_course/services/firestore_database.dart';

class JobsViewmodel with ChangeNotifier {
  JobsViewmodel({@required this.database});
  final Database database;

  bool _isLoading = false;
  bool _isEditing = false;
  Job _job;

  Future<void> createJob() async {
    final existedName = isEditing ? false : await _existedJobName();
    if (!existedName) {
      updateWith(isLoading: true);
      await database.setJob(_job);
    } else {
      throw FirebaseException(message: "name is existed", plugin: "");
    }
    updateWith(isLoading: false);
  }

  Stream<List<Job>> getJobs() {
    final jobsStream = database.jobsStream();

    // TODO convert stream to changeNotifire
    // jobsStream.listen((event) {
    // });
    return jobsStream;
  }

  Future<void> delete(Job item) async {
    await database.deleteJob(job);
  }

  Future<bool> _existedJobName() async {
    final jobs = await database.jobsStream().first;
    final List<String> names = jobs.map((e) => e.name).toList();
    return names.contains(_job.name);
  }

  String get nameValidator => _job.validName ? null : _job.invalidNameErrorText;
  String get ratePerHourValidator =>
      _job.validRatePerHour ? null : _job.invalidRateErrorText;

  void updateName(String name) => updateWith(job: _job.copyWith(name: name));
  void updateRate(int ratePerHour) =>
      updateWith(job: _job.copyWith(ratePerHour: ratePerHour));

  void updateWith({
    bool isLoading,
    bool isEditing,
    Job job,
    bool notify: true,
  }) {
    this._isLoading = isLoading ?? this.isLoading;
    this._isEditing = isEditing ?? this.isEditing;
    this._job = job ?? this.job;
    if (notify) notifyListeners();
  }

  //getters
  bool get isLoading => _isLoading;
  bool get isEditing => _isEditing;
  Job get job => _job ?? Job();
}
