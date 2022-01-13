class LocationWeather {
  const LocationWeather(
      {required this.woeID,
      required this.title,
      required this.sunRise,
      required this.sunSet,
      required this.forecast});

  final int woeID;
  final String title;
  final DateTime sunRise;
  final DateTime sunSet;
  final List<ConsolidatedWeather> forecast;

  LocationWeather.fromJson(Map<String, dynamic> json)
      : woeID = json['woeid'],
        title = json['title'],
        sunRise = DateTime.parse(json['sun_rise']),
        sunSet = DateTime.parse(json['sun_set']),
        forecast = (json['consolidated_weather'] as List<dynamic>)
            .map((dynamic e) =>
                ConsolidatedWeather.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'woeID': woeID,
        'title': title,
        'sunRise': sunRise,
        'sunSet': sunSet,
        'forecast': forecast.map((e) => e.toJson()).toList()
      };

  @override
  String toString() => 'The WOE ID for $title is $woeID';
}

class ConsolidatedWeather {
  const ConsolidatedWeather(
      {required this.weatherStateName,
      required this.applicableDate,
      required this.minTemp,
      required this.maxTemp,
      required this.theTemp,
      required this.windSpeed,
      required this.windDirection,
      required this.airPressure,
      required this.humidity,
      required this.visibility});

  final String weatherStateName;
  final DateTime applicableDate;
  final double minTemp;
  final double maxTemp;
  final double theTemp;
  final double windSpeed;
  final String windDirection;
  final double airPressure;
  final double humidity;
  final double visibility;

  ConsolidatedWeather.fromJson(Map<String, dynamic> json)
      : weatherStateName = json['weather_state_name'],
        applicableDate = DateTime.parse(json['applicable_date']),
        minTemp = json['min_temp'] + 0.0,
        maxTemp = json['max_temp'] + 0.0,
        theTemp = json['the_temp'] + 0.0,
        windSpeed = json['wind_speed'] + 0.0,
        windDirection = json['wind_direction_compass'],
        airPressure = json['air_pressure'] + 0.0,
        humidity = json['humidity'] + 0.0,
        visibility = json['visibility'] + 0.0;

  Map<String, dynamic> toJson() => {
        'weatherStateName': weatherStateName,
        'applicableDate': applicableDate,
        'minTemp': minTemp,
        'maxTemp': maxTemp,
        'theTemp': theTemp,
        'windSpeed': windSpeed,
        'windDirection': windDirection,
        'airPressure': airPressure,
        'humidity': humidity,
        'visibility': visibility
      };

  @override
  String toString() =>
      'The temperature on ${applicableDate.toString()} will be $theTemp Celsius.';
}
