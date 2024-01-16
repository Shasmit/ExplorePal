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
              '79e2c7b495mshe55c89711b47a28p1eb1bejsn96348472f60d',
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
