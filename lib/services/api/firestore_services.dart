import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirestoreServices {
  FirestoreServices._();

  static FirestoreServices get instance => FirestoreServices._();

  Future<void> setData(
      {@required String apiPath, @required Map<String, dynamic> data}) async {
    final refrernce = FirebaseFirestore.instance.doc(apiPath);
    log('apiPath : $apiPath \n data : $data');
    await refrernce.set(data);
  }

  Stream<List<T>> clollectionStream<T>({
    @required String path,
    @required T Function(Map<String, dynamic> data, String docId) builder,
    Query Function(Query query) queryBuilder,
  }) {
    Query query = FirebaseFirestore.instance.collection(path);
    if (queryBuilder != null)
      query = queryBuilder(query); //reuse query to filter it
    final snapshots = query.snapshots();
    return snapshots.map(
      (collection) =>
          collection.docs.map((doc) => builder(doc.data(), doc.id)).toList(),
    );
  }

  Future<void> deleteData({
    @required String path,
  }) async {
    final refernce = FirebaseFirestore.instance.doc(path);
    await refernce.delete();
  }
}
