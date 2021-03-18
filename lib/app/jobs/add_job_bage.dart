import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/jobs/jobs_viewmodel.dart';
import 'package:time_tracker_flutter_course/app/models/job.dart';
import 'package:time_tracker_flutter_course/common_widgets/show_exception_alert_dialog.dart';

class AddJobPage extends StatefulWidget {
  AddJobPage({Key key, @required this.viewmodel}) : super(key: key);
  final JobsViewmodel viewmodel;

  static Future<void> create(BuildContext context) async {
    final viewmodel = Provider.of<JobsViewmodel>(context, listen: false);
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => AddJobPage(viewmodel: viewmodel),
      fullscreenDialog: true,
    ));
  }

  @override
  _AddJobPageState createState() => _AddJobPageState();
}

class _AddJobPageState extends State<AddJobPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameFocusNode = FocusNode();
  final _rateFocusNode = FocusNode();
  JobsViewmodel get _viewmodel => widget.viewmodel;

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _rateFocusNode.dispose();
    _viewmodel.updateWith(job: Job(), notifiy: false);
    super.dispose();
  }

  Future<void> _submetJob(BuildContext context) async {
    if (_validateAndSaveForm()) {
      try {
        await _viewmodel.createJob();
        Navigator.of(context).pop();
      } catch (e) {
        showExceptionAlertDialog(
          context,
          title: "operation feild",
          exception: e,
        );
      }
    }
  }

  _validateAndSaveForm() {
    final form = _formKey.currentState;
    form.save();
    if (form.validate()) {
      return true;
    } else {
      return false;
    }
  }

  _nameEditingComplete(BuildContext context) {
    FocusScope.of(context).requestFocus(_rateFocusNode);
  }

  List<Widget> _buildChildren(BuildContext context) {
    return [
      _buildNameTextField(context),
      SizedBox(height: 8.0),
      _buildRatePerHourTextField(context),
    ];
  }

  _buildNameTextField(BuildContext context) {
    return TextFormField(
      focusNode: _nameFocusNode,
      initialValue: _viewmodel.isEditing ? _viewmodel.job.name : null,
      decoration: InputDecoration(
        labelText: 'Name',
        hintText: 'programmer',
        enabled: _viewmodel.isLoading == false,
      ),
      autocorrect: false,
      validator: (_) => _viewmodel.nameValidator,
      textInputAction: TextInputAction.next,
      onSaved: (name) => _viewmodel.updateName(name),
      onEditingComplete: () => _nameEditingComplete(context),
    );
  }

  _buildRatePerHourTextField(BuildContext context) {
    return TextFormField(
      focusNode: _rateFocusNode,
      initialValue:
          _viewmodel.isEditing ? _viewmodel.job.rateperHour.toString() : null,
      decoration: InputDecoration(
        labelText: 'RatePerHour',
        hintText: '0',
        enabled: _viewmodel.isLoading == false,
      ),
      autocorrect: false,
      validator: (_) => _viewmodel.ratePerHourValidator,
      keyboardType:
          TextInputType.numberWithOptions(decimal: false, signed: false),
      textInputAction: TextInputAction.done,
      onSaved: (ratePerHour) =>
          _viewmodel.updateRate(int.tryParse(ratePerHour)),
      onEditingComplete: () => _submetJob(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_viewmodel.isEditing ? "Edit Job" : "Create Job"),
        actions: [
          TextButton(
            onPressed: () => _submetJob(context),
            child: Text(
              "save",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: _buildChildren(context),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
