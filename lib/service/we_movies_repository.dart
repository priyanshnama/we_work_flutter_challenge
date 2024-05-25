import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:we_work_flutter_challenge/data/movie.dart';

class WeMoviesRepository {
  static final WeMoviesRepository _instance = WeMoviesRepository._internal();

  factory WeMoviesRepository() => _instance;

  WeMoviesRepository._internal();

  static const String _apiKey =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2YTg3ZTY4MDMyODIwMTIzZmQ0Yzg0YjQzNDhjYjc3ZCIsInN1YiI6IjY2Mjg5NDExOTFmMGVhMDE0YjAwOWU1ZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.6zIM73Giwg5M4wP6MX8KDCpee7IMnpnLTZUyMpETb08';
  static const String _baseUrl = 'https://api.themoviedb.org/3/movie';
  static const String _configurationUrl =
      'https://api.themoviedb.org/3/configuration';
  static const Map<String, String> _headers = {
    'Authorization': 'Bearer $_apiKey',
    'accept': 'application/json',
  };

  String? _secureBaseUrl;
  List<String>? _posterSizes;

  Future<void> _fetchConfiguration() async {
    final response =
        await http.get(Uri.parse(_configurationUrl), headers: _headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _secureBaseUrl = data['images']['secure_base_url'];
      _posterSizes = List<String>.from(data['images']['poster_sizes']);
    } else {
      throw Exception('Failed to load configuration');
    }
  }

  Future<List<Movie>> _fetchMovies(String endpoint) async {
    final response = await http.get(Uri.parse(endpoint), headers: _headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> moviesJson = data['results'];
      return moviesJson.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load movies from $endpoint');
    }
  }

  Future<List<Movie>> getTopRatedMovies({int page = 1}) =>
      _fetchMovies('$_baseUrl/top_rated?language=en-US&page=$page');

  Future<List<Movie>> getNowPlayingMovies({int page = 1}) =>
      _fetchMovies('$_baseUrl/now_playing?language=en-US&page=$page');

  Future<String> getFullImageUrl(String imagePath,
      {String size = 'w500'}) async {
    if (_secureBaseUrl == null || _posterSizes == null) {
      await _fetchConfiguration();
    }

    if (!_posterSizes!.contains(size)) {
      throw Exception('Invalid image size: $size');
    }

    return '$_secureBaseUrl$size$imagePath';
  }
}
