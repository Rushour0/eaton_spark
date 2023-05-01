import 'package:flutter/material.dart';

class HorizontalSection extends StatelessWidget {
  const HorizontalSection({
    Key? key,
    this.scrollable = true,
    required this.children,
    this.height = 100,
    this.spacing = 8,
    this.verticalPadding = 8,
    this.title = 'Horizontal Section',
    this.rightPadding = 8,
  }) : super(key: key);
  final double height;
  final double spacing;
  final String title;
  final bool scrollable;
  final double verticalPadding;
  final double rightPadding;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            scrollable
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: children
                          .map(
                            (e) => Padding(
                              padding: EdgeInsets.only(
                                  right: rightPadding, bottom: verticalPadding),
                              child: e,
                            ),
                          )
                          .toList(),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: children
                        .map(
                          (e) => Padding(
                            padding: EdgeInsets.only(
                                right: rightPadding, bottom: verticalPadding),
                            child: e,
                          ),
                        )
                        .toList(),
                  ),
          ]
              .map((e) =>
                  Padding(padding: EdgeInsets.only(top: spacing), child: e))
              .toList()),
    );
  }
}
