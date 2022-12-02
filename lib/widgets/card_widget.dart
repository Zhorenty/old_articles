import 'package:flutter/material.dart';

import '../utilities/forecast_util.dart';

Widget cardWidget(AsyncSnapshot snapshot, int index) {
  var forecastList = snapshot.data.list;
  var dayOfWeek = '';
  DateTime date =
      DateTime.fromMillisecondsSinceEpoch(forecastList[index].dt * 1000);
  var fullDate = Util.getFormattedDate(date);
  dayOfWeek = fullDate.split(',')[0];
  var icon = forecastList[index].getIconUrl();
  var temp = forecastList[index].temp.day.toStringAsFixed(0);

  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Center(
        child: Padding(
          padding: const EdgeInsets.all(11.0),
          child: Text(
            dayOfWeek,
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('$temp°C', style: TextStyle(color: Colors.white, fontSize: 35)),
          Image.network(
            icon,
            scale: 1.2,
            color: Colors.white,
          )
        ],
      )
    ],
  );
}
