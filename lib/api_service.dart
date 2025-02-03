import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String apiKey = "d00b5b1b36294cb23a8035d0316b8476"; // Ganti dengan API key Anda
  static const String baseUrl = "https://api.themoviedb.org/3";

  // Fetch trending movies
  static Future<List<dynamic>> fetchTrendingMovies() async {
    final url = Uri.parse('$baseUrl/trending/movie/day?api_key=$apiKey');
    print("Fetching data from: $url"); // Cetak URL yang digunakan

    final response = await http.get(url);
    print("API Response Status: ${response.statusCode}"); // Cetak status code
    print("API Response Body: ${response.body}"); // Cetak respons body

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to load trending movies. Status code: ${response.statusCode}');
    }
  }
}