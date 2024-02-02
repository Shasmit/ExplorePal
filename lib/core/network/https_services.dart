import 'package:exploree_pal/config/constants/api_endpoint.dart';
import 'package:http/http.dart' as http;

class HttpsServices {
  http.Client client = http.Client();

  Future<http.Response> getWeatherDetails(String lat, String lon) async {
    try {
      var response = await http.get(
        Uri.https(
          ApiEndpoints.weatherUrl,
          "/city/latlon/$lat/$lon",
        ),
        headers: {
          'X-RapidAPI-Key':
              '29fbf802ebmsh3746cbcf0e72495p16717ajsn4353d8508c69',
          'X-RapidAPI-Host': 'open-weather13.p.rapidapi.com',
        },
      );
      return response;
    } catch (error) {
      // Handle potential errors gracefully
      print("Error fetching weather details: $error");
      rethrow; // Rethrow the error to allow for further handling
    }
  }
}
