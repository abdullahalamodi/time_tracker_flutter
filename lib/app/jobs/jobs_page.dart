import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/job_entries/entries_page.dart';
import 'package:time_tracker_flutter_course/app/jobs/add_job_bage.dart';
import 'package:time_tracker_flutter_course/app/jobs/job_list_item.dart';
import 'package:time_tracker_flutter_course/app/jobs/jobs_viewmodel.dart';
import 'package:time_tracker_flutter_course/app/models/job.dart';
import 'package:time_tracker_flutter_course/common_widgets/list_item_builder.dart';
import 'package:time_tracker_flutter_course/common_widgets/show_exception_alert_dialog.dart';
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
                      job: item, isEditing: true, notify: false);
                  EntriesPage.create(context);
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
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () => AddJobPage.create(
                context, viewmodel), //check if lesten true use provider.of...
          ),
        ],
      ),
      body: _buildContent(context),
    );
  }
}
