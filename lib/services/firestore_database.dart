import 'package:flutter/foundation.dart';
import 'package:time_tracker_flutter_course/app/models/job.dart';
import 'package:time_tracker_flutter_course/services/api/api_path.dart';
import 'package:time_tracker_flutter_course/services/api/firestore_services.dart';

abstract class Database {
  Future<void> setJob(Job job);
  Stream<List<Job>> jobsStream();
  Future<void> deleteJob(Job job);
}

class FirestoreDatabase extends Database {
  FirestoreDatabase({@required this.uid});
  final String uid;

  final services = FirestoreServices.instance;

  @override
  Future<void> setJob(Job job) =>
      services.setData(apiPath: ApiPath.job(uid, job.id), data: job.toMap());

  @override
  Stream<List<Job>> jobsStream() => services.clollectionStream<Job>(
        path: ApiPath.jobs(uid),
        builder: (data, id) => Job.fromMap(data, id: id),
      );

  @override
  Future<void> deleteJob(Job job) => services.deleteData(
        path: ApiPath.job(uid, job.id),
      );
}
