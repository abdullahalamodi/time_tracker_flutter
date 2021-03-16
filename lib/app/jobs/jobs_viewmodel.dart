import 'package:flutter/foundation.dart';
import 'package:time_tracker_flutter_course/app/models/job.dart';
import 'package:time_tracker_flutter_course/services/firestore_database.dart';

class JobsViewmodel {
  JobsViewmodel({@required this.database});
  final Database database;

  Future<void> createJob(Job job) async {
    await database.createJop(job);
  }

  Stream<List<Job>> getJobs() {
    final jobsStream = database.getJobs();
    // TODO convert stream to changeNotifire
    // jobsStream.listen((event) {
    // });
    return jobsStream;
  }
}
