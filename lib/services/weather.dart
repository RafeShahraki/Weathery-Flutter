import 'package:weathery/services/networking.dart';
import 'package:weathery/services/location.dart';

class WeatherModel {
  late String url;
  late String url2;

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    url =
        'https://api.open-meteo.com/v1/forecast?latitude=${location.latitude}&longitude=${location.longitude}&current=temperature_2m,weather_code';
    url2 =
        'https://api.bigdatacloud.net/data/reverse-geocode-client?latitude=${location.latitude}&longitude=${location.longitude}&localityLanguage=en';

    NetworkHelper networkHelper = NetworkHelper(url, url2);
    var weatherData = await networkHelper.getdata();
    return weatherData;
  }

  Future<dynamic> getLocationCity() async {
    Location location = Location();
    await location.getCurrentLocation();
    url =
        'https://api.open-meteo.com/v1/forecast?latitude=${location.latitude}&longitude=${location.longitude}&current=temperature_2m,weather_code';
    url2 =
        'https://api.bigdatacloud.net/data/reverse-geocode-client?latitude=${location.latitude}&longitude=${location.longitude}&localityLanguage=en';
    NetworkHelper networkHelper = NetworkHelper(url, url2);
    var cityname = await networkHelper.getCity();
    return cityname;
  }

  String getWeatherIcon(int condition) {
    if (condition == 0) {
      return '☀️'; // Clear sky
    } else if (condition == 1 || condition == 2 || condition == 3) {
      return '⛅'; // Mainly clear, partly cloudy, and overcast
    } else if (condition == 45 || condition == 48) {
      return '🌫️'; // Fog and depositing rime fog
    } else if (condition == 51 || condition == 53 || condition == 55) {
      return '🌦️'; // Drizzle: Light, moderate, and dense intensity
    } else if (condition == 56 || condition == 57) {
      return '🌧️❄️'; // Freezing Drizzle: Light and dense intensity
    } else if (condition == 61 || condition == 63 || condition == 65) {
      return '🌧️'; // Rain: Slight, moderate and heavy intensity
    } else if (condition == 66 || condition == 67) {
      return '🌧️🧊'; // Freezing Rain: Light and heavy intensity
    } else if (condition == 71 || condition == 73 || condition == 75) {
      return '❄️'; // Snow fall: Slight, moderate, and heavy intensity
    } else if (condition == 77) {
      return '🌨️'; // Snow grains
    } else if (condition == 80 || condition == 81 || condition == 82) {
      return '🌦️'; // Rain showers: Slight, moderate, and violent
    } else if (condition == 85 || condition == 86) {
      return '🌨️'; // Snow showers slight and heavy
    } else if (condition == 95) {
      return '⛈️'; // Thunderstorm: Slight or moderate
    } else if (condition == 96 || condition == 99) {
      return '⛈️🧊'; // Thunderstorm with slight and heavy hail
    } else {
      return '❓'; // Unknown condition
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
