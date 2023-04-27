import 'package:flutter/material.dart';

class HorizontalSection extends StatelessWidget {
  const HorizontalSection({
    Key? key,
    this.scrollable = true,
    required this.children,
    this.height = 100,
    this.spacing = 8,
    this.title = 'Horizontal Section',
  }) : super(key: key);
  final double height;
  final double spacing;
  final String title;
  final bool scrollable;
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
              child: scrollable
                  ? CustomScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),

                      // anchor: 0.0,
                      slivers: children
                          .map(
                            (e) => SliverToBoxAdapter(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  right: 8,
                                ),
                                child: e,
                              ),
                            ),
                          )
                          .toList(),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisSize: MainAxisSize.min,
                      children: children
                          .map(
                            (e) => Padding(
                              padding: EdgeInsets.only(
                                right: 8,
                              ),
                              child: e,
                            ),
                          )
                          .toList(),
                    ),
            ),
          ]
              .map((e) =>
                  Padding(padding: EdgeInsets.only(top: spacing), child: e))
              .toList()),
    );
  }
}
