import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yo_app/models/weather.dart';

import '../utilities/forecast_util.dart';

class DetailView extends StatelessWidget {
  final AsyncSnapshot<WeatherForecast> snapshot;
  const DetailView({required this.snapshot, super.key});

  @override
  Widget build(BuildContext context) {
    var pressure = snapshot.data!.list![0].pressure * 0.750062;
    var humidity = snapshot.data!.list![0].humidity;
    var windSpeed = snapshot.data!.list![0].speed;
    return Column(
      children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Util.getItem(FontAwesomeIcons.temperatureThreeQuarters,
                  pressure.round(), 'mm Hg'),
              Util.getItem(FontAwesomeIcons.cloudRain, humidity, '%'),
              Util.getItem(FontAwesomeIcons.wind, windSpeed.toInt(), 'm/s')
            ],
          ),
        ),
      ],
    );
  }
}
