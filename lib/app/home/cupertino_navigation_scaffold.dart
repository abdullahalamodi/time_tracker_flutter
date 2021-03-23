import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/home/tab_item.dart';

class CupertinoNavigationScaffold extends StatelessWidget {
  const CupertinoNavigationScaffold({
    Key key,
    @required this.currentTab,
    @required this.onSelectTab,
    @required this.builder,
  }) : super(key: key);
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;
  final WidgetBuilder builder;

  BottomNavigationBarItem _buildItem(TabItem item) {
    final itemData = TabItemData.allTabs[item];
    final color = item == currentTab ? Colors.indigo : Colors.grey;
    return BottomNavigationBarItem(
      icon: Icon(itemData.icon, color: color),
      label: itemData.title,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          _buildItem(TabItem.jobs),
          _buildItem(TabItem.entries),
          _buildItem(TabItem.profile),
        ],
        onTap: (index) => onSelectTab(TabItem.values[index]),
      ),
      tabBuilder: (context, __) => builder(context),
    );
  }
}
