import 'dart:developer';

import 'package:flutter/material.dart';

typedef ItemBuilder<T> = Widget Function(BuildContext context, T item);

class ListItemBuilder<T> extends StatelessWidget {
  const ListItemBuilder({
    Key key,
    this.snapshot,
    this.itemBuilder,
  }) : super(key: key);
  final AsyncSnapshot<List<T>> snapshot;
  final ItemBuilder<T> itemBuilder;

  @override
  Widget build(BuildContext context) {
    if (snapshot.hasData) {
      final items = snapshot.data;
      return items.isNotEmpty
          ? ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, i) => itemBuilder(context, items[i]),
            )
          : Center(
              child: Text("empty list"),
            );
    } else if (snapshot.hasError) {
      log(snapshot.error.toString());
      return Center(
        child: Text("some thing goes wrong"),
      );
    } else
      return Center(child: CircularProgressIndicator());
  }
}
