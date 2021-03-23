import 'package:flutter/foundation.dart';
import 'package:time_tracker_flutter_course/app/models/entry.dart';
import 'package:time_tracker_flutter_course/app/models/job.dart';
import 'package:time_tracker_flutter_course/services/api/api_path.dart';
import 'package:time_tracker_flutter_course/services/api/firestore_services.dart';

abstract class Database {
  Future<void> setJob(Job job);
  Stream<List<Job>> jobsStream();
  Future<void> deleteJob(Job job);
  Future<void> setEntry(Entry entry);
  Stream<List<Entry>> entriesStream(Job job);
  Future<void> deleteEntry(Entry entry);
}

class FirestoreDatabase extends Database {
  FirestoreDatabase({@required this.uid});
  final String uid;

  final _services = FirestoreServices.instance;

  @override
  Future<void> setJob(Job job) =>
      _services.setData(apiPath: ApiPath.job(uid, job.id), data: job.toMap());

  @override
  Stream<List<Job>> jobsStream() => _services.clollectionStream<Job>(
        path: ApiPath.jobs(uid),
        builder: (data, id) => Job.fromMap(data, id: id),
      );

  @override
  Future<void> deleteJob(Job job) => _services.deleteData(
        path: ApiPath.job(uid, job.id),
      );

  @override
  Future<void> setEntry(Entry entry) => _services.setData(
        apiPath: ApiPath.entry(uid, entry.id),
        data: entry.toMap(),
      );

  @override
  Stream<List<Entry>> entriesStream(Job job) =>
      _services.clollectionStream<Entry>(
        path: ApiPath.entries(uid),
        queryBuilder: job != null
            ? (query) => query.where('jobId', isEqualTo: job.id)
            : null,
        builder: (data, docId) => Entry.fromMap(data, docId),
      );

  @override
  Future<void> deleteEntry(Entry entry) => _services.deleteData(
        path: ApiPath.job(uid, entry.id),
      );
}
