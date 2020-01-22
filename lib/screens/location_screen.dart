import 'package:flutter/material.dart';
import 'package:westher_app/utilities/constants.dart';
import 'dart:convert';
import 'package:westher_app/services/weather.dart';
import 'city_screen.dart';
import 'dart:math';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.data});

  final data;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  void initState() {
    super.initState();
    updateUI(widget.data);
  }

  var temp;
  int condition;
  String cityName;
  String weatherIcon;
  String message;
  WeatherModel weatherModel = WeatherModel();

  void updateUI(dynamic data) {
    setState(() {
      temp = jsonDecode(data)['main']['temp'];
      condition = jsonDecode(data)['weather'][0]['id'];
      cityName = jsonDecode(data)['name'];
      weatherIcon = weatherModel.getWeatherIcon(condition);
      message = weatherModel.getMessage(temp);
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
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
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
                  FlatButton(
                    onPressed: () async {
                      String dataN = await weatherModel.getWeatherResult();
                      updateUI(dataN);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      String newData;
                      newData = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CityScreen();
                      }));
                      updateUI(newData);
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      temp.toStringAsFixed(0) + '˚c',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$weatherIcon',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$message' + " in $cityName!",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
