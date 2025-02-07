class WeatherModel {
  final String cityName;
  String timezone;
  String sunrise;
  String sunset;
  final String description;
  final double temperature;
  final double feelsLike;
  final int pressure;
  final int humidity;
  final double windSpeed;
  final int seaLevel;

  WeatherModel({
    required this.cityName,
    required this.timezone,
    required this.sunrise,
    required this.sunset,
    required this.description,
    required this.temperature,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.windSpeed,
    required this.seaLevel,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json["name"].toString(),
      timezone: json["timezone"].toString(),
      sunrise: json["sys"]["sunrise"].toString(),
      sunset: json["sys"]["sunset"].toString(),
      description: json["weather"][0]["description"],
      temperature: (json["main"]["temp"] - 273.15), // Convert Kelvin to Celsius
      feelsLike: (json["main"]["feels_like"] - 273.15),
      pressure: json["main"]["pressure"],
      humidity: json["main"]["humidity"],
      windSpeed: json["wind"]["speed"].toDouble(),
      seaLevel: json["main"].containsKey("sea_level") ? json["main"]["sea_level"] : 0,
    );
  }
}
