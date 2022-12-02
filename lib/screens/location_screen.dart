import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:yo_app/api/weather_api.dart';
import 'package:yo_app/screens/weather_forecast_screen.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  void getLocationData() async {
    var weatherInfo = WeatherApi().fetchWeatherForecast();

    if (weatherInfo == null) {
      print('weather info is null $weatherInfo');
    }
    Navigator.push(context, MaterialPageRoute(builder: ((context) {
      return WeatherForecastScreen(locationWeather: weatherInfo);
    })));
  }

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SpinKitDualRing(
        color: Colors.black87,
        size: 100,
      ),
    ));
  }
}
