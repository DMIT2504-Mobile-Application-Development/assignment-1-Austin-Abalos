import 'dart:convert';
import 'package:http/http.dart' as http;

const String weatherApiKey = '484a9574fdd242a8226b3ff41091bc54';
const String currentWeatherEndpoint = 'https://api.openweathermap.org/data/2.5/weather';

Future<dynamic> getWeatherForCity({required String city}) async {
  final url = Uri.parse('$currentWeatherEndpoint?units=metric&q=$city&appid=$weatherApiKey');
  try {
    final response = await http.get(url);

    if ( response.statusCode != 200) {
      throw Exception ("There was a problem with the request: $response  received");
    }
    else {
      return jsonDecode(response.body);
    }
  }
  catch (exception) {
    throw Exception('There was a problem with the request: $exception');
  }
}
