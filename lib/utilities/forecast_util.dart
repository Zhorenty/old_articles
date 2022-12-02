import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Util {
  static String getFormattedDate(DateTime dateTime) {
    return DateFormat('EEEE, MMM d, y').format(dateTime);
  }

  static getItem(IconData iconData, int value, String units) {
    return Column(
      children: [
        Icon(iconData, size: 40, color: Colors.black87),
        const SizedBox(height: 10),
        Text('$value', style: const TextStyle(fontSize: 20)),
        const SizedBox(height: 10),
        Text(units, style: const TextStyle(fontSize: 20))
      ],
    );
  }
}
