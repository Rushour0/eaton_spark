import 'package:flutter/material.dart';

class GridSection extends StatelessWidget {
  const GridSection({
    super.key,
    required this.children,
    this.height = 100,
    this.spacing = 8,
    this.title = 'Grid Section',
    this.crossAxisCount = 2,
  });
  final double height;
  final double spacing;
  final String title;
  final int crossAxisCount;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(
              height: height,
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (notification) {
                  notification.disallowIndicator();
                  return true;
                },
                child: GridView.count(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: spacing,
                  mainAxisSpacing: spacing,
                  childAspectRatio: 1,
                  physics: const NeverScrollableScrollPhysics(),
                  children: children,
                ),
              ),
            ),
          ]
              .map((e) =>
                  Padding(padding: EdgeInsets.only(top: spacing), child: e))
              .toList()),
    );
  }
}
