import 'package:weathery/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:weathery/services/location.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weathery/services/weather.dart';
import 'package:weathery/screens/location_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  ButtonStyle style = ElevatedButton.styleFrom(
    backgroundColor: Color.fromARGB(255, 127, 11, 11),
  );
  void getLocationData() async {
    var weatherData = await WeatherModel().getLocationWeather();
    var city = await WeatherModel().getLocationCity();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            LocationScreen(weatherData: weatherData, cityData: city),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocationData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitRotatingCircle(color: Colors.white, size: 50.0),
      ),
    );
  }
}
