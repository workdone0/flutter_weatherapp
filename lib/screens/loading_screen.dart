import 'package:flutter/material.dart';
import 'package:westher_app/services/weather.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  String data;

  void getLocation() async {
    WeatherModel model = WeatherModel();
    data = await model.getWeatherResult();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        data: data,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitWave(
          color: Colors.cyan,
          size: 60.0,
          duration: Duration(milliseconds: 1000),
        ),
      ),
    );
  }
}
