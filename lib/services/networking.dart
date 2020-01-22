import 'package:http/http.dart';

class NetworkService {
  NetworkService({this.longitude, this.latitude, this.apiKey});

  final double longitude;
  final double latitude;
  final String apiKey;

  String data;

  Future<void> getWeatherNetwork() async {
    Response response = await get(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric');
    if (response.statusCode >= 200 && response.statusCode < 300) {
      data = response.body;
    } else {
      print(response.statusCode);
    }
  }
}
