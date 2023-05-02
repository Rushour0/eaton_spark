import 'package:eaton_spark/src/globals/colors.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    required this.iconWidget,
    required this.title,
    this.onTap,
    this.isLongCard = false,
    this.navigates = true,
  });

  final Widget iconWidget;
  final String title;
  final Function()? onTap;
  final bool isLongCard;
  final bool navigates;

  @override
  Widget build(BuildContext context) {
    if (isLongCard) {
      return Card(
        child: InkWell(
          overlayColor: MaterialStateProperty.all(GlobalColor.primary),
          customBorder: RoundedRectangleBorder(
            side: BorderSide(color: GlobalColor.primary, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            leading: iconWidget,
            title: Text(title),
            trailing: navigates ? Icon(Icons.arrow_forward_ios_rounded) : null,
          ),
          onTap: onTap ?? () {},
        ),
      );
    }

    return Card(
      child: InkWell(
        overlayColor: MaterialStateProperty.all(GlobalColor.primary),
        customBorder: RoundedRectangleBorder(
          side: BorderSide(color: GlobalColor.primary, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        onTap: onTap ?? () {},
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 70,
                width: 70,
                child: iconWidget,
              ),
              Text(title),
            ]
                .map((e) =>
                    Padding(padding: EdgeInsets.fromLTRB(8, 0, 8, 8), child: e))
                .toList()),
      ),
    );
  }
}
