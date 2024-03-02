import 'dart:convert'; // Import the 'dart:convert' library for json.decode

import 'package:http/http.dart' as http;

class WeatherFunction {
  Future<Map<String, dynamic>> getWeatherData(String cityName) async {
    const apiKey =
        "59de6cb604c4b8814918999b5949469d"; // Replace with your OpenWeatherMap API key
    final apiUrl =
        "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey";

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // Successful response
        Map<String, dynamic> weatherData = json.decode(response.body);
        return weatherData;
      } else {
        // Handle error
        print("Error: ${response.statusCode}");
        // Return an empty map or a default value in case of an error
        return {};
      }
    } catch (error) {
      // Handle network error
      print("Error: $error");
      // Return an empty map or a default value in case of an error
      return {};
    }
  }
}
