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
    TabItem.jobs:
        const TabItemData(icon: Icons.format_align_justify, title: 'Jobs'),
    TabItem.entries:
        const TabItemData(icon: Icons.emoji_events_rounded, title: 'entries'),
    TabItem.profile:
        const TabItemData(icon: Icons.format_align_justify, title: 'profile'),
  };
}
