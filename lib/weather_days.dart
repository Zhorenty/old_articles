class WeatherProperties {
  String day;
  String degree;
  WeatherProperties({required this.day, required this.degree});
  // factory WeatherProperties.fromJson(Map<String, dynamic> json) =>
  //     WeatherProperties(
  //       day: json["day"],
  //       degree: json["degree"],
  //     );

  // Map<String, dynamic> toJson() => {
  //       "day": day,
  //       "degree": degree,
  //     };
}

final days = [
  WeatherProperties(day: 'Friday', degree: '6'),
  WeatherProperties(day: 'Saturday', degree: '5'),
  WeatherProperties(day: 'Sunday', degree: '22'),
  WeatherProperties(day: 'Monday', degree: '24'),
  WeatherProperties(day: 'Tuesday', degree: '28'),
];
