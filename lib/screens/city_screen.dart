import 'package:flutter/material.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({super.key});

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  static var _cityname = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                cursorColor: Colors.blueGrey[800],
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                    hintText: 'Enter City Name',
                    hintStyle: TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Colors.black87,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide.none,
                    ),
                    icon: Icon(Icons.location_city,
                        color: Colors.black87, size: 50)),
                onChanged: (value) {
                  _cityname = value;
                },
              ),
            ),
            SizedBox(
                height: 100,
                width: 380,
                child: TextButton(
                    onPressed: () {
                      Navigator.pop(context, _cityname);
                    },
                    child: const Text(
                      'Get Weather',
                      style: TextStyle(color: Colors.black, fontSize: 40),
                    )))
          ],
        ),
      )),
    );
  }
}
