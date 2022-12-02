import 'package:flutter/material.dart';
import 'package:yo_app/models/weather.dart';
import 'package:yo_app/widgets/card_widget.dart';

class WeekList extends StatelessWidget {
  final AsyncSnapshot<WeatherForecast> snapshot;

  const WeekList({required this.snapshot, super.key});

  @override
  Widget build(BuildContext context) {
    var forecastList = snapshot.data!.list;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text('7-day weather forecast'.toUpperCase(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        SizedBox(height: 15),
        SizedBox(
          height: 120,
          width: double.infinity,
          child: ListView.separated(
            separatorBuilder: ((context, index) => SizedBox(width: 10)),
            itemCount: forecastList!.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: ((context, index) {
              return Container(
                width: MediaQuery.of(context).size.width / 2.7,
                color: Colors.black87,
                child: cardWidget(snapshot, index),
              );
            }),
          ),
        )
      ],
    );
  }
}
