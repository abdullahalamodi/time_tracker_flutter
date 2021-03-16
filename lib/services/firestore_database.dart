import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:time_tracker_flutter_course/app/models/job.dart';
import 'package:time_tracker_flutter_course/services/api_path.dart';

abstract class Database {
  Future<void> createJop(Job job);
  Stream<List<Job>> jobsStream();
}

class FirestoreDatabase extends Database {
  FirestoreDatabase({@required this.uid});
  final String uid;

  @override
  Future<void> createJop(Job job) =>
      _setData(apiPath: ApiPath.job(uid, 'jobId'), data: job.toMap());

  @override
  Stream<List<Job>> jobsStream() => _clollectionStream<Job>(
        path: ApiPath.jobs(uid),
        builder: (data) => Job.fromMap(data),
      );

  Future<void> _setData(
      {@required String apiPath, @required Map<String, dynamic> data}) async {
    final refrernce = FirebaseFirestore.instance.doc(apiPath);
    log('apiPath : $apiPath \n data : $data');
    await refrernce.set(data);
  }

  Stream<List<T>> _clollectionStream<T>({
    @required String path,
    @required T Function(Map<String, dynamic> data) builder,
  }) {
    final refernce = FirebaseFirestore.instance.collection(path);
    final snapshots = refernce.snapshots();
    return snapshots.map(
      (collection) =>
          collection.docs.map((doc) => builder(doc.data())).toList(),
    );
  }
}
