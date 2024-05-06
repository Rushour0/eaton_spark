import 'package:eaton_spark/src/bloc/home/bloc.dart';
import 'package:eaton_spark/src/bloc/services_tab/bloc.dart';
import 'package:eaton_spark/src/globals/colors.dart';
import 'package:eaton_spark/src/models/home_tabs.dart';
import 'package:eaton_spark/src/models/service_tab.dart';
import 'package:eaton_spark/src/services/google_maps/maps.dart';
import 'package:eaton_spark/src/widgets/bottomsheet/service_bottomsheet.dart';
import 'package:eaton_spark/src/widgets/card/icon_card.dart';
import 'package:eaton_spark/src/widgets/textfield/map_query_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_animations/animation_builder/custom_animation_builder.dart';

class ChooseService extends StatelessWidget {
  const ChooseService({super.key});
  static const _options = {
    ServicesTabMode.charge_now: ImageIcon(
      AssetImage('assets/images/charging-station.png'),
    ),
    ServicesTabMode.intercity: ImageIcon(
      AssetImage('assets/images/route.png'),
    ),
    ServicesTabMode.battery_swap: ImageIcon(
      AssetImage('assets/images/battery.png'),
    ),
    ServicesTabMode.plan_charge: Icon(Icons.calendar_month),
  };

  static Widget _contents = Container();

  @override
  Widget build(BuildContext context) {
    final HomeTabState homeTabState = context.watch<HomeTabBloc>().state;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return BlocProvider<ServicesTabBloc>.value(
      value: context.read<ServicesTabBloc>(),
      child: BlocBuilder<ServicesTabBloc, ServicesTabState>(
          buildWhen: (previous, current) {
        if (current.mode != previous.mode) {
          print('mode changed');
          return true;
        }
        return false;
      }, builder: (context, state) {
        if (homeTabState is FirstLoadOfTab &&
            homeTabState.mode == HomeTabMode.services) {
          _contents = Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _options.entries
                .map(
                  (e) => CustomAnimationBuilder<double>(
                    control: Control.play,
                    tween: Tween<double>(begin: 1, end: 0),
                    duration: const Duration(milliseconds: 500),
                    delay: Duration(milliseconds: e.key.index * 300),
                    curve: Curves.fastOutSlowIn,
                    builder: (bcontext, value, child) => Padding(
                      padding: EdgeInsets.only(right: 8.0 + 100 * value),
                      child: IconCard(
                          size: screenWidth * 0.2,
                          icon: e.value,
                          text: e.key.title,
                          isSelected: e.key == state.mode,
                          onTap: () async {
                            BlocProvider.of<ServicesTabBloc>(context)
                                .changeMode(e.key);
                            if (e.key == ServicesTabMode.charge_now) {
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor:
                                      GlobalColor.primary.withAlpha(100),
                                  enableDrag: true,
                                  context: context,
                                  builder: (context) =>
                                      const ServicesTabBottomSheet());
                            }
                          }),
                    ),
                  ),
                )
                .toList(),
          );
        } else {
          _contents = Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _options.entries
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: IconCard(
                        size: screenWidth * 0.2,
                        icon: e.value,
                        text: e.key.title,
                        isSelected: e.key == state.mode,
                        onTap: () async {
                          BlocProvider.of<ServicesTabBloc>(context)
                              .changeMode(e.key);
                          if (e.key == ServicesTabMode.charge_now) {
                            showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor:
                                    GlobalColor.primary.withAlpha(100),
                                enableDrag: true,
                                context: context,
                                builder: (context) => const ServicesTabBottomSheet());
                          }
                        }),
                  ),
                )
                .toList(),
          );
        }

        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              _contents,
              const Divider(
                color: Colors.lightGreen,
                thickness: 2,
                indent: 8,
                endIndent: 8,
              ),
              if (state.mode != ServicesTabMode.charge_now &&
                  state.mode != ServicesTabMode.map)
                MapInputField(mode: state.mode)
              else
                null,
            ]
                .map((e) => Padding(
                    padding: const EdgeInsets.only(bottom: 8), child: e))
                .toList(),
          ),
        );
      }),
    );
  }
}

class MapInputField extends StatelessWidget {
  const MapInputField({super.key, required this.mode});

  final ServicesTabMode mode;

  static final TextEditingController _fromController = TextEditingController();
  static final TextEditingController _toController = TextEditingController();
  static final TextEditingController _batterydateController =
      TextEditingController();
  static final TextEditingController _batterytimeController =
      TextEditingController();
  static final TextEditingController _batteryLocationController =
      TextEditingController();
  static final TextEditingController _plandateController =
      TextEditingController();
  static final TextEditingController _plantimeController =
      TextEditingController();
  static final TextEditingController _planLocationController =
      TextEditingController();

  static final Map<ServicesTabMode, List<Widget>> _modeWise = {
    ServicesTabMode.intercity: <Widget>[
      MapQueryField(controller: _fromController, labelText: 'From'),
      MapQueryField(controller: _toController, labelText: 'To'),
    ],
    ServicesTabMode.battery_swap: <Widget>[
      MapQueryField(
          controller: _batteryLocationController, labelText: 'Location'),
      MapQueryField(controller: _batterydateController, labelText: 'Date'),
      MapQueryField(controller: _batterytimeController, labelText: 'Time'),
    ],
    ServicesTabMode.plan_charge: <Widget>[
      MapQueryField(controller: _planLocationController, labelText: 'Location'),
      MapQueryField(controller: _plandateController, labelText: 'Date'),
      MapQueryField(controller: _plantimeController, labelText: 'Time'),
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withAlpha(20),
          borderRadius: BorderRadius.circular(8),
        ),
        child: ExpansionTile(
          key: const Key('map_input_field'),
          initiallyExpanded: true,
          title: Text(
            mode.title,
            style: TextStyle(
              color: GlobalColor.primary.withRed(240),
              fontSize: 18,
            ),
          ),
          children: _modeWise[mode]! +
              [
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: () {
                      GoogleMapService.mode(
                        mode,
                        source: _fromController.text,
                        destination: _toController.text,
                        batteryLocation: _batteryLocationController.text,
                        batteryDate: _batterydateController.text,
                        batteryTime: _batterytimeController.text,
                        planLocation: _planLocationController.text,
                        planDate: _plandateController.text,
                        planTime: _plantimeController.text,
                      );
                      showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: GlobalColor.primary.withAlpha(100),
                          enableDrag: true,
                          context: context,
                          builder: (context) => const ServicesTabBottomSheet());
                    },
                    child: const Text('Go'),
                  ),
                ),
              ],
        ),
      ),
    );
  }
}
