import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/home/cupertino_navigation_scaffold.dart';
import 'package:time_tracker_flutter_course/app/home/tab_item.dart';
import 'package:time_tracker_flutter_course/app/jobs/jobs_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

final Map<TabItem, WidgetBuilder> navigationPages = {
  TabItem.jobs: (context) => JobsPage.create(context),
  TabItem.entries: (context) => Container(),
  TabItem.profile: (context) => JobsPage.create(context),
};

class _HomePageState extends State<HomePage> {
  TabItem currentTab = TabItem.jobs;

  _select(TabItem item) {
    setState(() => currentTab = item);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoNavigationScaffold(
      currentTab: currentTab,
      onSelectTab: _select,
      builder: (context) => navigationPages[currentTab](context),
    );
  }
}
