import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String apiKey = "d00b5b1b36294cb23a8035d0316b8476"; // API key Anda
  static const String baseUrl = "https://api.themoviedb.org/3";

  // Fetch trending movies
  static Future<List<dynamic>> fetchTrendingMovies() async {
    final url = Uri.parse('$baseUrl/trending/movie/day?api_key=$apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to load trending movies');
    }
  }

  // Fetch genre list
  static Future<Map<int, String>> fetchGenres() async {
    final url = Uri.parse('$baseUrl/genre/movie/list?api_key=$apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final genres = data['genres'] as List;
      return { for (var genre in genres) genre['id']: genre['name'] };
    } else {
      throw Exception('Failed to load genres');
    }
  }
}