import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:time_tracker_flutter_course/app/models/job.dart';
import 'package:time_tracker_flutter_course/services/api_path.dart';
import 'package:time_tracker_flutter_course/services/firestore_services.dart';

abstract class Database {
  Future<void> createJop(Job job);
  Stream<List<Job>> jobsStream();
}

class FirestoreDatabase extends Database {
  FirestoreDatabase({@required this.uid});
  final String uid;

  final services = FirestoreServices.instance;

  @override
  Future<void> createJop(Job job) =>
      services.setData(apiPath: ApiPath.job(uid, 'jobId'), data: job.toMap());

  @override
  Stream<List<Job>> jobsStream() => services.clollectionStream<Job>(
        path: ApiPath.jobs(uid),
        builder: (data) => Job.fromMap(data),
      );
}
