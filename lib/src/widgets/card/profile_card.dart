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
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    if (isLongCard) {
      return Card(
        child: InkWell(
          overlayColor: MaterialStateProperty.all(GlobalColor.primary),
          customBorder: RoundedRectangleBorder(
            side: const BorderSide(color: GlobalColor.primary, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          onTap: onTap ?? () {},
          child: ListTile(
            leading: iconWidget,
            title: Text(title),
            trailing: navigates ? const Icon(Icons.arrow_forward_ios_rounded) : null,
          ),
        ),
      );
    }

    return Card(
      child: InkWell(
        overlayColor: MaterialStateProperty.all(GlobalColor.primary),
        customBorder: RoundedRectangleBorder(
          side: const BorderSide(color: GlobalColor.primary, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        onTap: onTap ?? () {},
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              
              SizedBox(
                height: screenWidth * 0.2,
                width: screenWidth * 0.2,
                child: iconWidget,
              ),
              Text(title),
            ]
                .map((e) =>
                    Padding(padding: const EdgeInsets.fromLTRB(8, 0, 8, 8), child: e))
                .toList()),
      ),
    );
  }
}
