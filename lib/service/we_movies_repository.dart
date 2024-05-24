import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:we_work_flutter_challenge/data/movie.dart';

class WeMoviesRepository {
  static const String _apiKey = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2YTg3ZTY4MDMyODIwMTIzZmQ0Yzg0YjQzNDhjYjc3ZCIsInN1YiI6IjY2Mjg5NDExOTFmMGVhMDE0YjAwOWU1ZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.6zIM73Giwg5M4wP6MX8KDCpee7IMnpnLTZUyMpETb08';
  static const String _baseUrl = 'https://api.themoviedb.org/3/movie';
  static const String _configurationUrl = 'https://api.themoviedb.org/3/configuration';

  String? _secureBaseUrl;
  List<String>? _posterSizes;

  Future<void> _fetchConfiguration() async {
    final response = await http.get(
      Uri.parse(_configurationUrl),
      headers: {
        'Authorization': 'Bearer $_apiKey',
        'accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _secureBaseUrl = data['images']['secure_base_url'];
      _posterSizes = List<String>.from(data['images']['poster_sizes']);
    } else {
      throw Exception('Failed to load configuration');
    }
  }

  Future<List<Movie>> getTopRatedMovies() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/top_rated?language=en-US&page=1'),
      headers: {
        'Authorization': 'Bearer $_apiKey',
        'accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> moviesJson = data['results'];
      return moviesJson.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load top-rated movies');
    }
  }

  Future<List<Movie>> getNowPlayingMovies() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/now_playing?language=en-US&page=1'),
      headers: {
        'Authorization': 'Bearer $_apiKey',
        'accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> moviesJson = data['results'];
      return moviesJson.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load now-playing movies');
    }
  }

  Future<String> getFullImageUrl(String imagePath, {String size = 'w500'}) async {
    if (_secureBaseUrl == null || _posterSizes == null) {
      await _fetchConfiguration();
    }

    if (!_posterSizes!.contains(size)) {
      throw Exception('Invalid image size');
    }

    return '$_secureBaseUrl$size$imagePath';
  }
}
