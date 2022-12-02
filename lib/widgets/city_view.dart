import 'package:flutter/material.dart';
import 'package:yo_app/models/weather.dart';

import '../utilities/forecast_util.dart';

class CityView extends StatelessWidget {
  const CityView({required this.snapshot, super.key});

  final AsyncSnapshot<WeatherForecast> snapshot;

  @override
  Widget build(BuildContext context) {
    var forecastList = snapshot.data!.list;
    var formattedDate =
        DateTime.fromMillisecondsSinceEpoch(forecastList![0].dt * 1000);
    var city = snapshot.data!.city.name;
    var country = snapshot.data!.city.country;
    return Container(
      child: Column(children: [
        Text('$city, $country',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28,
            )),
        Text(
          '${Util.getFormattedDate(formattedDate)}',
          style: TextStyle(fontSize: 15),
        ),
      ]),
    );
  }
}
