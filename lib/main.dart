import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'weather_days.dart';

void main() {
  runApp(MainScreen());
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.deepOrange,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.deepOrange,
        title: Text('Weather Forecast'),
      ),
      body: Column(children: [
        CitySearch(),
        SizedBox(height: 40),
        Place(),
        SizedBox(height: 40),
        SizedBox(
          height: 150,
          child: WeatherList(),
        )
      ]),
    ));
  }
}

Widget CitySearch() {
  return Row(
    children: const [
      SizedBox(
        width: 15,
      ),
      Icon(
        Icons.search,
        size: 30,
        color: Colors.white,
      ),
      Expanded(
          child: TextField(
        decoration: InputDecoration(
          hintText: 'Enter City Name',
          hintStyle: TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepOrange, width: 5.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepOrange, width: 3.0),
          ),
        ),
        cursorColor: Colors.white,
      ))
    ],
  );
}

Widget Place() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
      Text(
        'Murmansk Oblast, RU',
        style: TextStyle(
            color: Colors.white, fontSize: 35, fontWeight: FontWeight.w300),
      ),
      SizedBox(height: 5),
      Text(
        'Friday, Mar 20, 2020',
        style: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.w300),
      )
    ],
  );
}

Widget WeatherList() {
  return Container(
      height: 120,
      padding: EdgeInsets.all(0),
      margin: EdgeInsets.all(5),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: days.length,
          itemBuilder: ((context, index) {
            WeatherProperties weatherDay = days[index];
            return Container(
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(15),
              height: 250,
              width: 200,
              color: Colors.deepOrange.shade200,
              child: Column(
                children: [
                  Text(
                    weatherDay.day,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "${weatherDay.degree} °F",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.w200),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Icon(
                        Icons.wb_sunny,
                        color: Colors.white,
                        size: 50,
                      )
                    ],
                  )
                ],
              ),
            );
          })));
}
