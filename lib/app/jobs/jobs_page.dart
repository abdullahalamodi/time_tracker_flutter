import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/jobs/jobs_viewmodel.dart';
import 'package:time_tracker_flutter_course/app/models/job.dart';
import 'package:time_tracker_flutter_course/common_widgets/show_alert_dialog.dart';
import 'package:time_tracker_flutter_course/common_widgets/show_exception_alert_dialog.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';
import 'package:time_tracker_flutter_course/services/firestore_database.dart';

class JobsPage extends StatelessWidget {
  const JobsPage({Key key, @required this.viewmodel}) : super(key: key);
  final JobsViewmodel viewmodel;

  static Widget create(BuildContext context) {
    final database = Provider.of<Database>(context);
    return Provider<JobsViewmodel>(
      create: (_) => JobsViewmodel(database: database),
      child: Consumer<JobsViewmodel>(
          builder: (_, viewmodel, __) => JobsPage(
                viewmodel: viewmodel,
              )),
    );
  }

  Future<void> _createJob(BuildContext context) async {
    try {
      await viewmodel.createJob(Job(name: "job 1"));
    } on FirebaseException catch (e) {
      showExceptionAlertDialog(
        context,
        title: "operation field",
        exception: e,
      );
    }
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await showAlertDialog(
      context,
      title: 'Logout',
      content: 'Are you sure that you want to logout?',
      cancelActionText: 'Cancel',
      defaultActionText: 'Logout',
    );
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jobes Page'),
        actions: <Widget>[
          TextButton(
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            onPressed: () => _confirmSignOut(context),
          ),
        ],
      ),
      body: _buildContent(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createJob(context),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return StreamBuilder<List<Job>>(
        stream: viewmodel.getJobs(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final jobs = snapshot.data;
            log(jobs.length.toString());
            return ListView.builder(
              itemCount: jobs.length,
              itemBuilder: (_, i) => Text(jobs[i].name),
            );
          } else if (snapshot.hasError) {
            log(snapshot.error.toString());
            return Center(
              child: Text("some thing goes wrong"),
            );
          } else
            return Center(child: CircularProgressIndicator());
        });
  }
}
