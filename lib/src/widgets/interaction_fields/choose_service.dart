import 'package:eaton_spark/src/bloc/services_tab/bloc.dart';
import 'package:eaton_spark/src/bloc/theme/bloc.dart';
import 'package:eaton_spark/src/globals/colors.dart';
import 'package:eaton_spark/src/models/service_tab.dart';
import 'package:eaton_spark/src/services/google_maps/maps.dart';
import 'package:eaton_spark/src/widgets/card/icon_card.dart';
import 'package:eaton_spark/src/widgets/textfield/map_query_field.dart';
import 'package:eaton_spark/src/widgets/textfield/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChooseService extends StatelessWidget {
  const ChooseService({super.key});
  static const _options = {
    ServicesTabMode.charge_now: ImageIcon(
      AssetImage('assets/images/charging-station.png'),
    ),
    ServicesTabMode.explore_route: ImageIcon(
      AssetImage('assets/images/route.png'),
    ),
    ServicesTabMode.battery_swap: ImageIcon(
      AssetImage('assets/images/battery.png'),
    ),
    ServicesTabMode.plan_charge: Icon(Icons.calendar_month),
  };

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ServicesTabBloc>.value(
      value: ServicesTabBloc(),
      child: BlocBuilder<ServicesTabBloc, ServicesTabState>(
          builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _options.entries
                    .map(
                      (e) => IconCard(
                        size: 70,
                        icon: e.value,
                        text: e.key.title,
                        isSelected: e.key == state.mode,
                        onTap: () => BlocProvider.of<ServicesTabBloc>(context)
                            .changeMode(e.key),
                      ),
                    )
                    .toList(),
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
  MapInputField({super.key, required this.mode});

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
    ServicesTabMode.explore_route: <Widget>[
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
    return ExpansionTile(
      key: Key('map_input_field'),
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
                },
                child: Text('Go'),
              ),
            ),
          ],
    );
  }
}
