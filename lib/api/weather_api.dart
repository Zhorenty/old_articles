import 'dart:developer';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:yo_app/models/weather.dart';
import 'package:yo_app/utilities/constants.dart';
import 'package:yo_app/utilities/location.dart';

class WeatherApi {
  Future<WeatherForecast> fetchWeatherForecast(
      {String? cityName, bool? isCity}) async {
    Location location = Location();
    await location.getCurrentLocation();

    Map<String, dynamic> params;

    if (isCity == true) {
      Map<String, dynamic> queryParameters = {
        //передаем город
        'APPID': Constants.WEATHER_APP_KEY,
        'units': 'metric',
        'q': cityName,
        'lang': 'ru'
      };
      params = queryParameters;
    } else {
      Map<String, dynamic> queryParameters = {
        'APPID': Constants.WEATHER_APP_KEY,
        'units': 'metric',
        'lat': location.latitude.toString(),
        'long': location.longitude.toString(),
        'lang': 'ru'
      };
      params = queryParameters;
    }

    var uri = Uri.https(Constants.WEATHER_BASE_URL_DOMAIN,
        Constants.WEATHER_FORECAST_PATH, params);

    log('request: ${uri.toString()}');

    var response = await http.get(uri);

    if (response.statusCode == 200) {
      return WeatherForecast.fromJson(json.decode(response.body));
    } else {
      throw Exception('error response');
    }
  }
}
