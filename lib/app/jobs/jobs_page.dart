import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/jobs/add_job_bage.dart';
import 'package:time_tracker_flutter_course/app/jobs/job_list_item.dart';
import 'package:time_tracker_flutter_course/app/jobs/jobs_viewmodel.dart';
import 'package:time_tracker_flutter_course/app/models/job.dart';
import 'package:time_tracker_flutter_course/common_widgets/list_item_builder.dart';
import 'package:time_tracker_flutter_course/common_widgets/show_alert_dialog.dart';
import 'package:time_tracker_flutter_course/common_widgets/show_exception_alert_dialog.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';
import 'package:time_tracker_flutter_course/services/firestore_database.dart';

class JobsPage extends StatelessWidget {
  const JobsPage({Key key, @required this.viewmodel}) : super(key: key);
  final JobsViewmodel viewmodel;

  static Widget create(BuildContext context) {
    final database = Provider.of<Database>(context);
    return ChangeNotifierProvider<JobsViewmodel>(
      create: (_) => JobsViewmodel(database: database),
      child: Consumer<JobsViewmodel>(
          builder: (_, viewmodel, __) => JobsPage(
                viewmodel: viewmodel,
              )),
    );
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

  Future<void> _delete(BuildContext context, Job item) async {
    try {
      await viewmodel.delete(item);
    } catch (e) {
      showExceptionAlertDialog(
        context,
        title: "oberation field",
        exception: e,
      );
    }
  }

  Widget _buildContent(BuildContext context) {
    return StreamBuilder<List<Job>>(
        stream: viewmodel.getJobs(),
        builder: (context, snapshot) {
          return ListItemBuilder<Job>(
            snapshot: snapshot,
            itemBuilder: (context, item) => Dismissible(
              key: Key("job_${item.id}"),
              background: Container(
                color: Colors.red,
              ),
              direction: DismissDirection.endToStart,
              onDismissed: (_) => _delete(context, item),
              child: JobListItem(
                onTap: () {
                  viewmodel.updateWith(
                      job: item, isEditing: true, notifiy: false);
                  AddJobPage.create(context);
                },
                job: item,
              ),
            ),
          );
        });
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
        onPressed: () => AddJobPage.create(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
