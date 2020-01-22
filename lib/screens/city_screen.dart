import 'package:flutter/material.dart';
import 'package:westher_app/utilities/constants.dart';
import 'package:westher_app/services/weather.dart';
import 'location_screen.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String cityName;
  String data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/city_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 50.0,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white30,
                    icon: Icon(Icons.location_city),
                    hintText: 'Enter City Name',
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onChanged: (value) {
                    cityName = value;
                  },
                ),
              ),
              FlatButton(
                onPressed: () async {
                  WeatherModel model = WeatherModel();
                  data = await model.getCityWeather(cityName);
                  Navigator.pop(context, data);
                },
                child: Text(
                  'Get Weather',
                  style: kButtonTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
