import 'package:flutter/material.dart';
import 'package:weathery/utilities/constants.dart';
import 'package:weathery/services/weather.dart';
import 'package:weathery/screens/city_screen.dart';

class LocationScreen extends StatefulWidget {
  final weatherData;
  final cityData;
  LocationScreen({this.cityData, this.weatherData});
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late String city;
  late int tempr;
  late int code;
  WeatherModel weatherModel = WeatherModel();
  @override
  void initState() {
    super.initState();
    updtaeUI(widget.weatherData, widget.cityData);
  }

  void updtaeUI(weatherdata, cityname) {
    setState(() {
      double temp = weatherdata['current']['temperature_2m'];
      tempr = temp.toInt();
      code = weatherdata['current']['weather_code'];
      var taregetCity = cityname['city'];
      city = taregetCity.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white.withValues(),
              BlendMode.dstATop,
            ),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var wdata = await WeatherModel().getLocationWeather();
                      var cdata = await WeatherModel().getLocationCity();
                      updtaeUI(wdata, cdata);
                    },
                    child: Icon(Icons.near_me, size: 50.0),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CityScreen()),
                      );
                    },
                    child: Icon(Icons.location_city, size: 50.0),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text('$tempr°', style: kTempTextStyle),
                    Text(
                      weatherModel.getWeatherIcon(code),
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  weatherModel.getMessage(tempr),
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
