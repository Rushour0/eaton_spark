import 'package:flutter/material.dart';

class VerticalSection extends StatelessWidget {
  const VerticalSection({
    super.key,
    this.scrollable = true,
    required this.children,
    this.height = 100,
    this.overallHeight = 400,
    this.spacing = 8,
    this.verticalPadding = 8,
    this.title = 'Vertical Section',
    this.rightPadding = 8,
  });
  final double height;
  final double overallHeight;
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
      child: Container(
        // padding: EdgeInsets.all(16),
        // decoration: BoxDecoration(
        //   // color: GlobalColor.primary,
        //   border: Border.all(color: GlobalColor.primary, width: 1),
        //   borderRadius: BorderRadius.circular(8),
        // ),
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
                  ? Container(
                      decoration: BoxDecoration(
                        // color: GlobalColor.primary,
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      height: overallHeight,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: children
                              .map(
                                (e) => Padding(
                                  padding: EdgeInsets.only(
                                      right: rightPadding,
                                      bottom: verticalPadding),
                                  child: e,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    )
                  : Column(
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
      ),
    );
  }
}
