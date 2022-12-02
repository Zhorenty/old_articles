import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:yo_app/api/weather_api.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:yo_app/screens/city_screen.dart';
import 'package:yo_app/widgets/city_view.dart';
import 'package:yo_app/widgets/detail_view.dart';
import 'package:yo_app/widgets/temp_view.dart';

import '../models/weather.dart';
import '../widgets/week_list.dart';

class WeatherForecastScreen extends StatefulWidget {
  const WeatherForecastScreen({this.locationWeather, super.key});

  final locationWeather;

  @override
  State<WeatherForecastScreen> createState() => _WeatherForecastScreenState();
}

class _WeatherForecastScreenState extends State<WeatherForecastScreen> {
  late Future<WeatherForecast> forecastObject;
  String _cityName = 'london';

  @override
  void initState() {
    super.initState();

    if (widget.locationWeather != null) {
      forecastObject = WeatherApi().fetchWeatherForecast();
    }

    forecastObject.then((weather) => log(weather.list![0].weather[0].main));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text('Weather forecast'),
        leading: IconButton(
          icon: const Icon(Icons.my_location),
          onPressed: () {
            setState(() {
              forecastObject = WeatherApi().fetchWeatherForecast();
            });
          },
        ),
        actions: [
          IconButton(
              onPressed: () async {
                var tappedName = await Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return const CityScreen();
                }));
                setState(() {
                  if (tappedName != null) {
                    _cityName = tappedName;
                    forecastObject = WeatherApi().fetchWeatherForecast(
                        cityName: _cityName, isCity: true);
                  } else {
                    throw Exception('город то введи');
                  }
                });
              },
              icon: const Icon(Icons.location_city))
        ],
      ),
      body: ListView(children: [
        FutureBuilder<WeatherForecast>(
          future: forecastObject,
          builder: (context, snapshot) {
            return snapshot.hasData
                ? Column(
                    children: [
                      const SizedBox(height: 30),
                      CityView(snapshot: snapshot),
                      const SizedBox(height: 40),
                      TempView(snapshot: snapshot),
                      const SizedBox(height: 80),
                      DetailView(snapshot: snapshot),
                      const SizedBox(height: 60),
                      WeekList(snapshot: snapshot),
                    ],
                  )
                : Column(
                    children: const [
                      SizedBox(
                        height: 300,
                      ),
                      Center(
                        child: SpinKitWave(
                          duration: Duration(milliseconds: 6500),
                          color: Colors.black,
                          size: 100,
                        ),
                      ),
                    ],
                  );
          },
        )
      ]),
    );
  }
}
