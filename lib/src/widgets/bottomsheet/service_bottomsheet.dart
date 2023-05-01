import 'package:eaton_spark/src/widgets/card/station_info_card.dart';
import 'package:flutter/material.dart';

class ServicesTabBottomSheet extends StatelessWidget {
  const ServicesTabBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.5,
      minChildSize: 0.1,
      builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          child: Container(
            child: Column(
              children: [
                Container(
                  height: 50,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Divider(
                        thickness: 5,
                        indent: 150,
                        endIndent: 150,
                      ),
                      Text(
                        'Choose Station',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                StationInfoCard(),
                StationInfoCard(),
                StationInfoCard(),
                StationInfoCard(),
                StationInfoCard(),
                StationInfoCard(),
                StationInfoCard(),
                StationInfoCard(),
                StationInfoCard(),
                StationInfoCard(),
                StationInfoCard(),
                StationInfoCard(),
                StationInfoCard(),
                StationInfoCard(),
                StationInfoCard(),
                StationInfoCard(),
                StationInfoCard(),
              ],
            ),
          )),
    );
  }
}
