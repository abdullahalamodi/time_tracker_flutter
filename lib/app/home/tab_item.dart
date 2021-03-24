import 'package:flutter/material.dart';

enum TabItem {
  jobs,
  entries,
  profile,
}

class TabItemData {
  const TabItemData({
    @required this.icon,
    @required this.title,
  });

  final IconData icon;
  final String title;

  static const Map<TabItem, TabItemData> allTabs = {
    TabItem.jobs: const TabItemData(icon: Icons.work, title: 'Jobs'),
    TabItem.entries:
        const TabItemData(icon: Icons.table_view, title: 'entries'),
    TabItem.profile: const TabItemData(icon: Icons.person, title: 'profile'),
  };
}
