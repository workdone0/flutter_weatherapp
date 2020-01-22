import 'package:http/http.dart';
import 'package:westher_app/services/location.dart';
import 'package:westher_app/services/networking.dart';

const apiKey = 'af7ecd10ca0f45173afb84882fc66fd6';
var longitude;
var latitude;
String data;

class WeatherModel {
  Future<String> getWeatherResult() async {
    Location location = Location();
    await location.getCurrentLocation();
    longitude = location.longitude;
    latitude = location.latitude;
    NetworkService networkwork = NetworkService(
        longitude: longitude, latitude: latitude, apiKey: apiKey);
    await networkwork.getWeatherNetwork();
    data = networkwork.data;
    print('hello');
    return data;
  }

  Future<String> getCityWeather(String city) async {
    Response response = await get(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric');
    if (response.statusCode >= 200 && response.statusCode < 300) {
      data = response.body;
    } else {
      print(response.statusCode);
    }
    return data;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(var temp) {
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
