import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/job_entries/add_entry_page.dart';
import 'package:time_tracker_flutter_course/app/job_entries/entity_list_item.dart';
import 'package:time_tracker_flutter_course/app/job_entries/entries_viewmodel.dart';
import 'package:time_tracker_flutter_course/app/jobs/add_job_bage.dart';
import 'package:time_tracker_flutter_course/app/jobs/jobs_viewmodel.dart';
import 'package:time_tracker_flutter_course/app/models/entry.dart';
import 'package:time_tracker_flutter_course/common_widgets/list_item_builder.dart';

class EntriesPage extends StatelessWidget {
  const EntriesPage({Key key, @required this.entriesViewModel})
      : super(key: key);
  final EntriesViewModel entriesViewModel;

  static Future<void> create(BuildContext context) async {
    final jobsViewmodel = Provider.of<JobsViewmodel>(context, listen: false);
    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider<EntriesViewModel>(
            create: (_) => EntriesViewModel(
                jobsViewmodel: jobsViewmodel, database: jobsViewmodel.database),
            child: Consumer<EntriesViewModel>(
              builder: (_, entriesViewmodel, __) => EntriesPage(
                entriesViewModel: entriesViewmodel,
              ),
            ),
          ),
          fullscreenDialog: false,
        ));
  }

  _delete(BuildContext context, Entry item) {}

  _buildContent(BuildContext context) => StreamBuilder<List<Entry>>(
        stream: entriesViewModel.entriesStream(),
        builder: (context, snapshot) => ListItemBuilder<Entry>(
          snapshot: snapshot,
          itemBuilder: (context, item) => Dismissible(
            key: Key("entry_${item.id}"),
            background: Container(
              color: Colors.red,
            ),
            direction: DismissDirection.endToStart,
            onDismissed: (_) => _delete(context, item),
            child: EntryListItem(
              entry: item,
              job: entriesViewModel.job,
              onTap: () {
                entriesViewModel.updateWith(entry: item);
                AddEntryPage.create(context, entriesViewModel);
              },
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(entriesViewModel.job.name ?? ''),
        centerTitle: true,
        actions: [
          TextButton(
            child: Text(
              'Edit',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => AddJobPage.create(
              context,
              entriesViewModel.jobsViewmodel,
            ),
          )
        ],
      ),
      body: _buildContent(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () => AddEntryPage.create(context,
            entriesViewModel), //check if lesten true use provider.of...
        child: Icon(Icons.add),
      ),
    );
  }
}
